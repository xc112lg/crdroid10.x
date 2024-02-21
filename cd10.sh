#!/bin/bash



# Set default values for device and command
DEVICE="${1:-all}"  # If no value is provided, default to "all"
COMMAND="${2:-build}"  # If no value is provided, default to "build"
DELZIP="${3}"


# Remove existing build artifacts
# Update and install ccache
sudo apt-get update -y
sudo apt-get install -y apt-utils
sudo apt-get install -y ccache
export USE_CCACHE=1
ccache -M 100G
export CCACHE_DIR=/tmp/src/manifest/cc
echo $CCACHE_DIR
# Remove existing build artifacts
if [ "$DELZIP" == "delzip" ]; then
rm -rf out/target/product/*/*.zip  device/lge/msm8996-common
git clone https://github.com/LineageOS/android_device_lge_msm8996-common -b lineage-21 device/lge/msm8996-common
#some fixes will be push to source fter testing
cd device/lge/msm8996-common
git fetch https://github.com/xc112lg/android_device_lge_msm8996-common.git cd10
git cherry-pick aef6632c220ec671b69ed3564d37f74cca295ce2 7ac9890a15cbf0be818fa00c8374620fb5c737c1
cd ../../../
#added crdroid setting 
wget -N -P device/lge/msm8996-common/overlay/frameworks/base/core/res/res/values/ https://github.com/crdroidandroid/android_frameworks_base/raw/14.0/core/res/res/values/cr_config.xml
wget -N -P device/lge/msm8996-common/overlay/frameworks/base/packages/SystemUI/res/values/ https://github.com/crdroidandroid/android_frameworks_base/raw/14.0/packages/SystemUI/res/values/cr_config.xml
fi




# Clone the repository
rm -rf out/target/product/*/*.zip  device/lge/msm8996-common
git clone https://github.com/xc112lg/android_device_lge_msm8996-common -b test device/lge/msm8996-common

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
    m -j16 bacon
    lunch lineage_h870-userdebug
    m -j16 bacon
    lunch lineage_h872-userdebug
    m -j16 bacon
 
elif [ "$DEVICE" == "h872" ]; then
    echo "Building for h872..."
m installclean
    lunch lineage_h872-userdebug
    m -j16 bacon
elif [ "$DEVICE" == "h870" ]; then
    echo "Building for h870..."
m installclean
    lunch lineage_h870-userdebug
    m -j16 bacon
    lunch lineage_h872-userdebug
    m -j16 bacon
else
    echo "Building for the specified device: $DEVICE..."
    # Build for the specified device
    lunch "$DEVICE"
    m -j16 bacon

fi

# Additional build commands if needed
