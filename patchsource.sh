#!/bin/bash

. config.sh

cd $ROM_DIRECTORY

cd vendor/bliss
git revert 89d3b90b677b834bf67cbc8392312f647a85d502 #qti_kernel_headers
cd ..

cd $SCRIPTS_DIR