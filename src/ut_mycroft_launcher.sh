#!/usr/bin/env bash

MYCROFT_CORE_PATH=/home/phablet/.local/share/mycroft.hummlbach/mycroft-core
MYCROFT_DEPS_PATH=/opt/click.ubuntu.com/mycroft.hummlbach/current/mycroft-dependencies

cd /home/phablet

export SSH_AUTH_SOCK=0 
ssh -i /home/phablet/.ssh/mycroft_rsa -o StrictHostKeyChecking=no phablet@localhost \
"export PATH=$MYCROFT_DEPS_PATH/lib/git-core:$MYCROFT_DEPS_PATH/bin:$PATH; \
export LD_LIBRARY_PATH=$MYCROFT_DEPS_PATH/lib/:$MYCROFT_DEPS_PATH/lib/arm-linux-gnueabihf:$LD_LIBRARY_PATH; \
export PULSE_CLIENTCONFIG=/etc/pulse/touch-client.conf; \
export PULSE_PLAYBACK_CORK_STALLED=1; \
export PULSE_PROP=media.role=multimedia; \
export PULSE_SCRIPT=/etc/pulse/touch.pa; \
$MYCROFT_CORE_PATH/start-mycroft.sh all"

