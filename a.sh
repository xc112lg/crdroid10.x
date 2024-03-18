#!/bin/bash

rm -rf h870/* h872/* us997/* 
rm crdroid10.x/*.zip
rm crdroid10.x/*.img
rm crdroid10.x/*.txt
crave ssh -- ls
crave pull out/target/product/*/*.zip out/target/product/*/recovery.img out/target/product/*/*.json out/target/product/*/changelog_*.txt 
mv h870/recovery.img h870/recoveryh870.img
mv h872/recovery.img h872/recoveryh872.img
mv us997/recovery.img us997/recoveryus997.img

mkdir -p temp
mv h870/*.json h872/*.json us997/*.json ./temp

rm -rf android_vendor_crDroidOTA
git clone https://$GH_TOKEN@github.com/xc112lg/android_vendor_crDroidOTA
cp -n android_vendor_crDroidOTA/h872.json temp/h8721.json
cp -n android_vendor_crDroidOTA/h870.json temp/h8701.json
cp -n android_vendor_crDroidOTA/us997.json temp/us9971.json

cd temp
sed -n '/"response": \[/,/\]/p' h872.json | sed '1d;$d' > output.json;sed -e '/"response": \[/{r output.json' -e 'a,' -e '}' h8721.json > temp.json && mv temp.json h8721.json
sed -n '/"response": \[/,/\]/p' h870.json | sed '1d;$d' > output.json;sed -e '/"response": \[/{r output.json' -e 'a,' -e '}' h8701.json > temp.json && mv temp.json h8701.json
sed -n '/"response": \[/,/\]/p' us997.json | sed '1d;$d' > output.json;sed -e '/"response": \[/{r output.json' -e 'a,' -e '}' us9971.json > temp.json && mv temp.json us9971.json
cd ..
mv temp/h8721.json ./android_vendor_crDroidOTA/h872.json
mv temp/h8701.json ./android_vendor_crDroidOTA/h870.json
mv temp/us9971.json ./android_vendor_crDroidOTA/us997.json
cd android_vendor_crDroidOTA
git add .
git commit -m "update"
git push 
cd ..
if [ -z "$(find "$source_folder" -type f \( -name "*.zip" -o -name "*.img" \))" ]; then
    echo "No .zip or .img files found in $source_folder or its subdirectories. Exiting."
    exit 1
fi
mv h870/* h872/* us997/* ./crdroid10.x/ 

export GH_TOKEN=$(cat ../gh_token.txt)
gh auth login --with-token $GH_TOKEN
cd crdroid10.x
chmod u+x multi_upload.sh
. multi_upload.sh
