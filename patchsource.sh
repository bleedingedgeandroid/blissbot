#!/bin/bash

. config.sh

cd $ROM_DIRECTORY

cd vendor/bliss
curl -s https://github.com/BlissRoms/platform_vendor_bliss/commit/89d3b90b677b834bf67cbc8392312f647a85d502.patch | git apply -R - #qti_kernel_headers
addAndCommit
cd ../..

cd $SCRIPTS_DIR