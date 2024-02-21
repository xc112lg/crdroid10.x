# Remove local_manifests directory
rm -rf .repo/local_manifests
# Clone local_manifests repository
git clone https://github.com/krishnaspeace/local_manifests --depth 1 -b main .repo/local_manifests
repo init --depth 1 -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
repo sync -c -j16 --force-sync --no-clone-bundle --no-tags --prune
# Set up build environment
source build/envsetup.sh
# Lunch configuration
lunch lineage_ysl-userdebug
# Build confriguration
make bacon
