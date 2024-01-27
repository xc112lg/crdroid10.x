#!/bin/bash

# Check if gh command-line tool is installed
if ! command -v gh &> /dev/null; then
  echo "Error: GitHub CLI (gh) is not installed. Please install it from https://cli.github.com/ and try again."
  exit 1
fi

# Ensure the user is authenticated with GitHub
gh auth login

the version:"
read -r version

# Check if the tag already exists
if git rev-parse "$version" >/dev/null 2>&1; then
  # If the tag exists, prompt the user
  echo "Tag $version already exists. Do you want to delete and recreate it? (yes/no)"
  read -r response

  if [[ "$response" =~ ^[Yy][Ee][Ss]$ ]]; then
    # User chose to delete and recreate the tag
    git tag -d "$version"
    git push origin --delete "$version"
    echo "Deleted existing tag $version."
  else
    # User chose to cancel
    echo "Canceling the tag creation."
    exit 1
  fi
fi

# Create the tag
git tag -a "$version" -m "Release $version"
git push origin "$version"

# Initialize an array to store the filenames
declare -a filenames

#if [[ "$upload_all" =~ ^[Yy]$ ]]; then
  # Upload all .zip and .img files in the current directory
  filenames=(*.zip *.img)
#else
  # Ask the user to input the filenames
#  read -p "Enter the filenames (separated by spaces): " -a filenames
#fi




# Upload the files to the release
for filename in "${filenames[@]}"; do
  gh release upload "$version" "$filename" --clobber
done

# Display success message
echo "Files uploaded successfully."
