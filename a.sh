#!/bin/bash

rm -rf h870/* h872/* us997/* 
rm crdroid10.1/*.zip
crave pull cd10/out/target/product/*/*.zip cd10/out/target/product/*/recovery.img cd10/out/target/product/*/*.json cd10/out/target/product/*/changelog_*.txt 
mv h870/recovery.img h870/recoveryh870.img
mv h872/recovery.img h872/recoveryh872.img
mv us997/recovery.img us997/recoveryus997.img
mv h870/* h872/* us997/* ./crdroid10.1/ 
cd crdroid10.1
./multi_upload.sh