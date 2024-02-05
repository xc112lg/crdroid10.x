#!/bin/bash
cd test
rm -rf msm8996_lge_kernel
git clone --depth=1 https://github.com/xc112lg/msm8996_lge_kernel -b p2
cd msm8996_lge_kernel
./build_all.sh














