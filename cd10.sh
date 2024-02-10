#!/bin/bash
rm -rf out/target/product/*/*.zip device/lge/msm8996-common
sudo apt-get update -y
sudo apt-get install -y ccache
export USE_CCACHE=1
export CCACHE_DIR=/tmp/src/android/cc
ccache -M 100G
git clone https://github.com/xc112lg/android_device_lge_msm8996-common -b cd1 device/lge/msm8996-common && \
source build/envsetup.sh
m clean
lunch lineage_h872-eng
m -j16 bacon