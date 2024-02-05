#!/bin/bash
cd test
echo ldd --version
if [ -e 96990bd284a0abaa997cda2a42b434cfc31713f6.zip ]; then
    echo "File already exists. Skipping wget."
else
wget https://github.com/mvaisakh/gcc-arm/archive/96990bd284a0abaa997cda2a42b434cfc31713f6.zip
unzip 96990bd284a0abaa997cda2a42b434cfc31713f6.zip -d gcc-arm
fi

if [ -e 9bc49b70ec61e1937d7d44930f788d9a727b42e4.zip ]; then
    echo "File already exists. Skipping wget."
else
wget https://github.com/mvaisakh/gcc-arm64/archive/9bc49b70ec61e1937d7d44930f788d9a727b42e4.zip
unzip 9bc49b70ec61e1937d7d44930f788d9a727b42e4.zip -d gcc-arm64
fi
rm -rf msm8996_lge_kernel
git clone --depth=1 https://github.com/xc112lg/msm8996_lge_kernel -b p2
msm8996_lge_kernel
./msm8996_lge_kernel/build_all.sh














