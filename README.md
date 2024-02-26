# AOSP Build Releases
code to upload relases in gh
```bash
git clone https://github.com/xc112lg/Releases.git && cd Releases && ./release.sh
```
gh auth login --with-token ${{ secrets.GH_TOKEN }}