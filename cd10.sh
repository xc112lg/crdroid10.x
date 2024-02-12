#!/bin/bash

# Set default values for device and command
DEVICE="${1:-all}"  # If no value is provided, default to "all"
COMMAND="${2:-build}"  # If no value is provided, default to "build"
DELZIP="${3}"
wait_one_second() {
    sleep 1
}

# Remove existing build artifacts

# Remove existing build artifacts
if [ "$DELZIP" == "delzip" ]; then
wait_one_second && rm -rf out/target/product/*/*.zip  device/lge/msm8996-common
fi



# Update and install ccache
wait_one_second && sudo apt-get update -y
wait_one_second && sudo apt-get install -y ccache
wait_one_second && export USE_CCACHE=1
wait_one_second && export CCACHE_DIR=/tmp/src/android/cc
wait_one_second && ccache -M 100G

# Clone the repository
#wait_one_second && git clone https://github.com/xc112lg/android_device_lge_msm8996-common -b cd10 device/lge/msm8996-common

# Set up the build environment
source build/envsetup.sh


# Check if command is "clean"
if [ "$COMMAND" == "clean" ]; then
    echo "Cleaning..."
    m clean
fi

# Check if device is set to "all"
if [ "$DEVICE" == "all" ]; then
    echo "Building for all devices..."
    lunch lineage_us997-userdebug
    m -j15 bacon
    lunch lineage_h870-userdebug
    m -j15 bacon
    lunch lineage_h872-userdebug
    m -j15 bacon
 
elif [ "$DEVICE" == "h872" ]; then
    echo "Building for h872..."
    lunch lineage_h872-eng
        m -j15 bacon
elif [ "$DEVICE" == "h870" ]; then
    echo "Building for h870..."
    lunch lineage_us997-userdebug
    m -j15 bacon
    lunch lineage_h870-userdebug
    m -j15 bacon
else
    echo "Building for the specified device: $DEVICE..."
    # Build for the specified device
    lunch "$DEVICE"
    m -j15 bacon

fi

# Additional build commands if needed
