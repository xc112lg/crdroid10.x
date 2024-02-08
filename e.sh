#!/bin/bash


mkdir test1
cd test1

mkdir -p toolchains/arm-eabi
mkdir -p toolchains/aarch64-elf

wget https://github.com/mvaisakh/gcc-arm/archive/eccc903e268e5154c393bb47bea798ab7ff1f99c.zip
unzip -o eccc903e268e5154c393bb47bea798ab7ff1f99c.zip -d toolchains/arm-eabi

wget https://github.com/mvaisakh/gcc-arm64/archive/87861a3b86c91f9dfa9c433eea9dc035e612595e.zip
unzip -o 87861a3b86c91f9dfa9c433eea9dc035e612595e.zip -d toolchains/aarch64-elf

#rm -rf msm8996_lge_kernel
git clone --depth 1 https://github.com/xc112lg/msm8996_lge_kernel -b p3
cd msm8996_lge_kernel


./build_all.sh














