#!/bin/bash

mkdir -p toolchains/arm-eabi
mkdir -p toolchains/aarch64-elf





if [ -e d56ef67fc68095dd30358048ba5aa771cbbd5862.zip ]; then
    echo "File already exists. Skipping wget."
else
wget https://github.com/mvaisakh/gcc-arm/archive/d56ef67fc68095dd30358048ba5aa771cbbd5862.zip
unzip -o d56ef67fc68095dd30358048ba5aa771cbbd5862.zip -d toolchains/arm-eabi
fi

if [ -e 6c9a692939540ac64ebc619a59e98f5fc3d4b818.zip ]; then
    echo "File already exists. Skipping wget."
else
wget https://github.com/mvaisakh/gcc-arm64/archive/6c9a692939540ac64ebc619a59e98f5fc3d4b818.zip
unzip -o 6c9a692939540ac64ebc619a59e98f5fc3d4b818.zip -d toolchains/aarch64-elf
fi
unzip -o d56ef67fc68095dd30358048ba5aa771cbbd5862.zip -d toolchains/arm-eabi
unzip -o 6c9a692939540ac64ebc619a59e98f5fc3d4b818.zip -d toolchains/aarch64-elf
rm -rf msm8996_lge_kernel
git clone https://github.com/xc112lg/msm8996_lge_kernel -b p3
cd msm8996_lge_kernel


./build_all.sh














