#!/bin/bash

. config.sh

cd $ROM_DIRECTORY
. build/envsetup.sh

MESSAGE_R=$(cat $SCRIPTS_DIR/build_start)
MESSAGE=${MESSAGE_R/'__VARIANT__'/"$1"}
curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE"


set -o pipefail
blissify --$1 spes |& tee build.log
if [ $? == 0 ]; then
MESSAGE_R=$(cat $SCRIPTS_DIR/build_success)
MESSAGE=${MESSAGE_R/'__VARIANT__'/"$1"}
curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE" > /dev/null

# PACKAGE=$(grep -P "Package Complete: out/target/product/.*/.*" build.log | sed 's/Package Complete: //') Normal rom

PACKAGE=$(grep -P "Zip:  .*/out/target/product/.*/.*" build.log | sed 's/Zip:  //') #BlissROMs


echo "BUILD SUCCESS! Package: $PACKAGE"
echo "Uploading........."

curl -T "$PACKAGE" https://pixeldrain.com/api/file/ -o out/pixeldrain.json
PIXELDRAIN_ID=$(cat out/pixeldrain.json |  python3 -c "import sys, json; print(json.load(sys.stdin)['id'])")
PIXELDRAIN_LINK="https://pixeldrain.com/api/file/$PIXELDRAIN_ID"

MESSAGE_R=$(cat $SCRIPTS_DIR/release_template)
MESSAGE=${MESSAGE_R/'VARIANT'/"$1"}
MESSAGE=${MESSAGE/'DATE'/"$(date +\"%x\")"}
MESSAGE=${MESSAGE/'PIXELDRAIN_URL'/"$PIXELDRAIN_LINK"}
MESSAGE=${MESSAGE/'MD5SUM'/"$(md5sum $PACKAGE)"}

curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE" > /dev/null

else
MESSAGE_R=$(cat $SCRIPTS_DIR/build_fail)
MESSAGE=${MESSAGE_R/'__VARIANT__'/"$1"}
echo "making sure file is not empty" >> out/error.log
curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendDocument -F chat_id=$CHAT_ID -F caption="$MESSAGE" -F document=@out/error.log > /dev/null

echo "BUILD FAILED!"
fi