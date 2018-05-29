#!/usr/bin/env bash

MYCROFT_DATA_PATH=/home/phablet/.local/share/mycroft.hummlbach/
MYCROFT_CORE_TARGET=$MYCROFT_DATA_PATH/mycroft-core
MYCROFT_CORE_SOURCE=/opt/click.ubuntu.com/mycroft.hummlbach/current/mycroft-core.tar

if [ ! -d "$MYCROFT_CORE_TARGET" ]; then
    echo "Please wait"
    mkdir -p $MYCROFT_DATA_PATH
    tar -xf $MYCROFT_CORE_SOURCE --directory $MYCROFT_DATA_PATH
fi

