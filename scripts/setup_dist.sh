#!/usr/bin/env bash

#CACHE_PATH=/home/phablet/.cache/mycroft.hummlbach
#DATA_PATH=/home/phablet/.local/share/mycroft.hummlbach
#rm -rf dist/mycroft-core/scripts/logs
#ln -s $CACHE_PATH dist/mycroft-core/scripts/logs

echo "Building tar for mycroft-core to protect .git directory from click..."

cd ..
tar cf build/tmp/mycroft-core.tar -C dist mycroft-core
scripts/get_libs.py
cp -r dist/mycroft-dependencies/ build/tmp/
cd -
