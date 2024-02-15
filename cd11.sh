#!/bin/bash
rm -rf .repo
rm -rf .repo/local_manifests
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs 

git clone https://github.com/Lafactorial/local_manifest --depth 1 -b rising-14 .repo/local_manifests 


rm -rf prebuilts/clang/host/linux-x86/clang-latest

repo sync -c -j15 --force-sync --no-clone-bundle --no-tags



source build/envsetup.sh
riseup rising_tissot-userdebug 

croot 
ascend 

# Print out/build_date.txt
# cat out/build_date.txt
 
# Print SHA256
# sha256sum out/target/product/*/*.zip