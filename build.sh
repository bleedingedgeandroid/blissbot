#!/bin/bash

. config.sh

cd $ROM_DIRECTORY
bash $SCRIPTS_DIR/atomsync.sh

. build/envsetup.sh
MESSAGE_R=$(cat $SCRIPTS_DIR/build_start)
MESSAGE=${MESSAGE_R/'__VARIANT__'/"$1"}
curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE"

blissify --$1 spes