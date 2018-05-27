#!/usr/bin/env python3
# this is a modified version of get-libs.py which is part of checkbox.
# See http://bazaar.launchpad.net/~checkbox-dev/checkbox/trunk/view/head:/checkbox-touch/get-libs
#
# copyright 2018 by Tim Süberkrüb
# copyright 2014 canonical ltd.
# written by:
#   maciej kisielewski <maciej.kisielewski@canonical.com>
#
# checkbox is free software: you can redistribute it and/or modify
# it under the terms of the gnu general public license version 3,
# as published by the free software foundation.
#
# checkbox is distributed in the hope that it will be useful,
# but without any warranty; without even the implied warranty of
# merchantability or fitness for a particular purpose.  see the
# gnu general public license for more details.
#
# you should have received a copy of the gnu general public license
# along with checkbox.  if not, see <http://www.gnu.org/licenses/>.
"""
Download and extract .deb packages necessary to run checkbox-touch
Extraction is done to specific directories as required by click package

For typical development iteration, after hacking something in plainbox,
run ./get-libs --plainbox-only
"""

import apt
import apt_pkg
import collections
import os
import shutil
import subprocess
import tempfile
import urllib.request

# arch_list contains list of architectures for which the packages should be
# downloaded
arch_list = ['armhf']
# multiarch_list contains full architecture name as used in the directories
# in contents of click package
multiarch_list = ["arm-linux-gnueabihf"]

target_directory = 'deps/arm-linux-gnueabihf'

packages = ['flac', 'libportaudio2', 'git', 'build-essential']


def copy_tree(src, dest, preserve_symlinks=False):
    """
    copy files from src to dest using rsync
    """
    links_option = "-l" if preserve_symlinks else "-L"
    parent_dir = os.path.split(os.path.abspath(dest))[0]
    # adding trailing slash if it's not already there
    src = os.path.join(src, '')
    if not os.path.exists(parent_dir):
        os.makedirs(parent_dir)
    subprocess.check_call(["rsync", "-a", links_option, src, dest])


def prepare_uris():
    """
    prepare_uris function builds caches for architectures defined in arch_list
    and builds a dictionary of URLs indexed by (package_name, arch) tuple.
    It returns that dictionary.
    """

# uris will serve as a database of uris from which to download packages
    uris = dict()
    Source = collections.namedtuple('Source', ['uri', 'repositories'])
    sources = {
        'armhf': [Source('http://ports.ubuntu.com/ubuntu-ports/',
                         'main restricted universe')]
    }
    for arch in arch_list:
        print('Getting information about packages for {0} arch.'.format(arch))
        # prepare sources.list for apt
        with tempfile.TemporaryDirectory() as tmp:
            new_etc_apt = os.path.join(tmp, 'etc', 'apt')
            os.makedirs(new_etc_apt)
            # copy over trusted.gpg
            shutil.copyfile('/etc/apt/trusted.gpg',
                            os.path.join(new_etc_apt, 'trusted.gpg'))
            # copy over additional keyrings
            if os.path.exists('/etc/apt/trusted.gpg.d'):
                shutil.copytree('/etc/apt/trusted.gpg.d',
                                os.path.join(new_etc_apt, 'trusted.gpg.d'))
            sources_list = open(os.path.join(new_etc_apt, 'sources.list'), "w")
            for source in sources[arch]:
                sources_list.write(
                    "deb [arch={arch}] {uri} xenial {repositories}\n"
                    .format(arch=arch, uri=source.uri,
                            repositories=source.repositories))
            sources_list.close()
            apt_pkg.config["Apt::Architecture"] = arch
            cache = apt.Cache(rootdir=tmp)
            cache.update()
            cache.open(None)
            for pkg in packages:
                if pkg not in cache or len(cache[pkg].versions) < 1:
                    # package not found
                    raise Exception('Package {0} not found for arch {1}'
                                    .format(pkg, arch))
                # use first uri available
                uris[pkg, arch] = cache[pkg].versions[0].uri
    # return filled dictionary
    return uris


def get_package_from_url_and_extract(url, target_dir):
    filename = os.path.join(target_dir, url.split('/')[-1])
    print('retrieving {0}'.format(url))
    urllib.request.urlretrieve(url, filename)
    subprocess.check_call(["dpkg", "-x", filename, target_dir])


def main():
    os.makedirs(target_directory, exist_ok=True)
    uris = prepare_uris()
    # libs_urls contains list of .deb packages that will be downloaded and
    # extracted. After extraction contents of ./usr/lib are copied to ./lib
    libs_urls = []
    for package in packages:
        libs_urls += [uris[package, arch] for arch in arch_list]
    for lib in libs_urls:
        with tempfile.TemporaryDirectory() as tmp:
            get_package_from_url_and_extract(lib, tmp)
            # TODO: remove unwanted files from the extracted tree (e.g. *.h)
            usr_path = os.path.join(tmp, 'usr')
            if os.path.exists(usr_path):
                for (dirpath, dirnames, filenames) in os.walk(usr_path):
                    for dirname in dirnames:
                        copy_tree(os.path.join(usr_path, dirname),
                                  os.path.join(target_directory, dirname),
                                  preserve_symlinks=True)
                    break


if __name__ == "__main__":
    main()
