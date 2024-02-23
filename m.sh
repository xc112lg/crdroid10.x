#!/bin/bash

# Check if gh command-line tool is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI 'gh' not found. Downloading and installing..."
    wget https://github.com/cli/cli/releases/download/v2.40.1/gh_2.40.1_linux_amd64.tar.gz
    tar -xvf gh_2.40.1_linux_amd64.tar.gz
    sudo mv gh_*_linux_amd64/bin/gh /usr/local/bin/
    echo "GitHub CLI 'gh' installed successfully."
else
    echo "GitHub CLI 'gh' is already installed."
fi

# Check if user is already authenticated
if ! gh auth status &> /dev/null; then
    # User not authenticated, perform login
    gh auth login
else
    echo "Already authenticated with GitHub."
fi


# Set the version with default if not provided
version=${custom_version:-"crDroidAndroid-14.0-$(date '+%Y%m%d')"}

# Check if the tag already exists
while gh release view "$version" &> /dev/null; do
    # Tag exists, increment the version number
    echo "Tag $version already exists. Incrementing version number..."
    version="${version%-*}-$((${version##*-} + 1))-$(date '+%Y%m%d')"
done

# Create the new tag and push it to GitHub
git tag -a "$version" -m "Release $version"
git push origin "$version" --force

# Initialize an array to store the filenames
declare -a filenames

# Uncomment the following block if you want to upload all .zip and .img files in the current directory
filenames=(*.img)

# Otherwise, ask the user to input the filenames
# read -p "Enter the filenames (separated by spaces): " -a filenames

# Create the release on GitHub
if ! gh release create "$version" --title "Release $version" --notes "Release notes"; then
    echo "Error: Failed to create the release."
    exit 1
fi

# Upload the files to the release
for filename in "${filenames[@]}"; do
    gh release upload "$version" "$filename" --clobber
done

# Display success message
echo "Files uploaded successfully."
