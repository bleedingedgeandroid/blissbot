#!/bin/bash
# Repo sync handler. eventually this will handle failed stuffs

. config.sh

cd $ROM_DIRECTORY
echo $(pwd)

export PYTHONUNBUFFERED="1"
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all) |& tee Sync.1.log
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all) |& tee Sync.2.log

cd $SCRIPTS_DIR