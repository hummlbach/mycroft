#!/usr/bin/env bash

MYCROFT_DATA_PATH=/home/phablet/.local/share/mycroft.hummlbach/
MYCROFT_CORE_PATH=/home/phablet/.local/share/mycroft.hummlbach/mycroft-core
MYCROFT_DEPS_PATH=/opt/click.ubuntu.com/mycroft.hummlbach/current/mycroft-dependencies

if [ ! -d "$MYCROFT_CORE_PATH" ]; then
    echo "Please wait"
    mkdir -p $MYCROFT_DATA_PATH
    tar -xf /opt/click.ubuntu.com/mycroft.hummlbach/current/mycroft-core.tar \
        --directory $MYCROFT_DATA_PATH
fi

cd $MYCROFT_CORE_PATH

export PATH=$MYCROFT_DEPS_PATH/bin:$PATH
export LD_LIBRARY_PATH=$MYCROFT_DEPS_PATH/lib/:$MYCROFT_DEPS_PATH/lib/arm-linux-gnueabihf:$LD_LIBRARY_PATH

./start-mycroft.sh debug
