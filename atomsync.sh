#!/bin/bash
# Repo sync handler. eventually this will handle failed stuffs

. config.sh

cd $ROM_DIRECTORY
echo $(pwd)
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all) 