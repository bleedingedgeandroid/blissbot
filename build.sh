#!/bin/bash

. config.sh

cd $ROM_DIRECTORY
. build/envsetup.sh

MESSAGE_R=$(cat $SCRIPTS_DIR/build_start)
MESSAGE=${MESSAGE_R/'__VARIANT__'/"$1"}
curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE"

blissify --$1 spes |& tee build.log

if [ $? == 0 ]; then
MESSAGE_R=$(cat $SCRIPTS_DIR/build_success)
MESSAGE=${MESSAGE_R/'__VARIANT__'/"$1"}
curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE" > /dev/null

echo "BUILD SUCCESS!"
else
MESSAGE_R=$(cat $SCRIPTS_DIR/build_fail)
MESSAGE=${MESSAGE_R/'__VARIANT__'/"$1"}
echo "making sure file is not empty" >> out/error.log
curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendDocument -F chat_id=$CHAT_ID -F caption="$MESSAGE" -F document=@out/error.log > /dev/null

echo "BUILD FAILED!"
fi