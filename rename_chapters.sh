#!/bin/bash

# This script renames chapter files in the 'chapters' directory.
# It strips the part of the filename from the first underscore
# and renames the file to 'chXX.qmd', where 'chXX' is the
# part of the name before the underscore.

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the target directory
TARGET_DIR="chapters"

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Directory '$TARGET_DIR' not found."
    exit 1
fi

# Check if there are any .qmd files in the target directory
if ! ls "$TARGET_DIR"/*.qmd 1> /dev/null 2>&1; then
    echo "No .qmd files found in '$TARGET_DIR'."
    exit 1
fi

echo "Renaming files in '$TARGET_DIR'..."

# Loop through all .qmd files in the target directory
for file_path in "$TARGET_DIR"/*.qmd; do
  filename=$(basename "$file_path")
  
  # Extract the part of the filename before the first underscore
  # This uses shell parameter expansion for efficiency.
  new_basename="${filename%%_*}"
  
  # Get the file extension
  extension="${filename##*.}"
  
  # Construct the new filename
  new_filename="${new_basename}.${extension}"
  
  # Construct the full new path
  new_file_path="$TARGET_DIR/$new_filename"
  
  if [ "$file_path" != "$new_file_path" ]; then
    echo "  -> Renaming '$filename' to '$new_filename'"
    mv "$file_path" "$new_file_path"
  else
    echo "  -> Skipping '$filename', already in correct format."
  fi
done

echo ""
echo "All chapter files have been renamed." 