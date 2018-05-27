#!/usr/bin/env bash

BUILD_DIR=build
CACHE_PATH=/home/phablet/.cache/mycroft.hummlbach
DATA_PATH=/home/phablet/.local/share/mycroft.hummlbach

#rm -rf dist/mycroft-core/scripts/logs
#ln -s $CACHE_PATH dist/mycroft-core/scripts/logs

tar cf $BUILD_DIR/tmp/mycroft-core.tar -C dist mycroft-core

cp -r dist/mycroft-dependencies/ $BUILD_DIR/tmp/
