#!/bin/bash
curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s --
curl -O https://raw.githubusercontent.com/xc112lg/crave_aosp_builder/main/f/crave.conf
ls
crave run --no-patch --clean -- "mkdir -p cc && rm -rf scripts && git clone https://github.com/xc112lg/scripts.git -b cd10   &&  chmod u+x scripts/sync.sh &&bash scripts/sync.sh"















