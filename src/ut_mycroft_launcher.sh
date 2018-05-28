#!/usr/bin/env bash

MYCROFT_CORE_PATH=/home/phablet/.local/share/mycroft.hummlbach/mycroft-core
MYCROFT_DEPS_PATH=/opt/click.ubuntu.com/mycroft.hummlbach/current/mycroft-dependencies

cd $MYCROFT_CORE_PATH

export PATH=$MYCROFT_DEPS_PATH/bin:$PATH
export PATH=$MYCROFT_DEPS_PATH//lib/git-core:$PATH
export LD_LIBRARY_PATH=$MYCROFT_DEPS_PATH/lib/:$MYCROFT_DEPS_PATH/lib/arm-linux-gnueabihf:$LD_LIBRARY_PATH

./start-mycroft.sh all
