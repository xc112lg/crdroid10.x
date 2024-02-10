#!/bin/bash

# Remove existing build artifacts
rm -rf out/target/product/*/*.zip device/lge/msm8996-common

# Update and install ccache
sudo apt-get update -y
sudo apt-get install -y ccache
export USE_CCACHE=1
export CCACHE_DIR=/tmp/src/android/cc
ccache -M 100G

# Clone the repository
git clone https://github.com/xc112lg/android_device_lge_msm8996-common -b cd1 device/lge/msm8996-common && \

# Set up the build environment
source build/envsetup.sh

# Choose the build target
lunch lineage_h872-eng

# Check user input for cleaning
if [ "$1" == "clean" ]; then
    # Clean the build
    m clean
else
    # Build the ROM
    m -j16 bacon
fi
