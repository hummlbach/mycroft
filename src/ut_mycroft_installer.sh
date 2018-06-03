#!/usr/bin/env bash

MYCROFT_DATA_PATH=/home/phablet/.local/share/mycroft.hummlbach/
MYCROFT_CORE_TARGET=$MYCROFT_DATA_PATH/mycroft-core
MYCROFT_CORE_SOURCE=/opt/click.ubuntu.com/mycroft.hummlbach/current/mycroft-core.tar

if [ ! -d "$MYCROFT_CORE_TARGET" ]; then
    echo "Please wait"
    mkdir -p $MYCROFT_DATA_PATH
    tar -xf $MYCROFT_CORE_SOURCE --directory $MYCROFT_DATA_PATH
fi

mkdir -p /home/phablet/.ssh
mkdir -p /home/phablet/.cache/mycroft.hummlbach
chmod 700 /home/phablet/.ssh
cd /home/phablet/.ssh
ssh-keygen -f mycroft_rsa -t rsa -N ''
cd -
cat /home/phablet/.ssh/mycroft_rsa.pub >> /home/phablet/.ssh/authorized_keys
chmod 600 /home/phablet/.ssh/authorized_keys
chown -R phablet.phablet /home/phablet/.ssh
