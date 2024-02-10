#!/bin/bash

# Function to wait for 1 second
wait_one_second() {
    sleep 1
}

# Remove existing build artifacts
wait_one_second && rm -rf out/target/product/*/*.zip device/lge/msm8996-common

# Update and install ccache
wait_one_second && sudo apt-get update -y
wait_one_second && sudo apt-get install -y ccache
wait_one_second && export USE_CCACHE=1
wait_one_second && export CCACHE_DIR=/tmp/src/android/cc
wait_one_second && ccache -M 100G

# Clone the repository
wait_one_second && git clone https://github.com/xc112lg/android_device_lge_msm8996-common -b cd1 device/lge/msm8996-common && \

# Set up the build environment
wait_one_second && source build/envsetup.sh

# Choose the build target
wait_one_second && lunch lineage_h872-eng

# Check user input for cleaning
if [ "$1" == "clean" ]; then
    # Clean the build
    wait_one_second && m clean
else
    # Build the ROM
    wait_one_second && m -j16 bacon
fi
