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

# Ensure the user is authenticated with GitHub
gh auth login

# Ask for the release tag name
read -p "Enter the release tag name: " version

# Check if the tag already exists
if gh release view "$version" &> /dev/null; then
  # Tag exists, ask for confirmation to delete the tag and releases
  read -p "Tag $version already exists. Press Enter to delete it and its releases or Ctrl+C to cancel..."
  echo "Deleting existing tag and releases for $version..."
  gh release delete "$version" --yes
  git tag -d "$version"
  git push origin --delete "$version"
  echo "Existing tag and releases deleted."
fi

# Create the new tag and push it to GitHub
git tag -a "$version" -m "Release $version"
git push origin "$version" --force

# Initialize an array to store the filenames
declare -a filenames

# Uncomment the following block if you want to upload all .zip and .img files in the current directory
 filenames=(*.zip *.img)

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
