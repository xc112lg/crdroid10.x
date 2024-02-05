#!/bin/bash
wget https://github.com/mvaisakh/gcc-arm/archive/5abf4f3ca52b8db8fa6053ca33039dcf67699e9d.zip
unzip 5abf4f3ca52b8db8fa6053ca33039dcf67699e9d.zip -d gcc-arm
wget https://github.com/mvaisakh/gcc-arm64/archive/826063daf781521675ef6400fd44a98929635239.zip
unzip 826063daf781521675ef6400fd44a98929635239.zip -d gcc-arm64
git clone https://github.com/xc112lg/msm8996_lge_kernel -b p2
cd msm8996_lge_kernel
./build_all.sh














