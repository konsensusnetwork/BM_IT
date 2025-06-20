#!/bin/bash

# This script processes Quarto files from the 'chapters' directory.
# It copies each .qmd file to an 'edit' directory and then
# renders it to a .docx file inside the 'edit' directory.

# Exit immediately if a command exits with a non-zero status.
set -e

# Define source and destination directories
SOURCE_DIR="chapters"
EDIT_DIR="edit"

# Create the 'edit' directory if it doesn't exist
echo "Creating '$EDIT_DIR' directory if it doesn't exist..."
mkdir -p "$EDIT_DIR"

# Clean the 'edit' directory before starting
echo "Cleaning '$EDIT_DIR' directory..."
rm -rf "$EDIT_DIR"/*

# Check if there are any .qmd files in the source directory
if ! ls "$SOURCE_DIR"/*.qmd 1> /dev/null 2>&1; then
    echo "No .qmd files found in '$SOURCE_DIR'."
    exit 1
fi

# Loop through all .qmd files in the source directory
for file_path in "$SOURCE_DIR"/*.qmd; do
  filename=$(basename "$file_path")
  
  echo "Processing $filename..."

  # Copy the file to the edit directory
  echo "  -> Copying to '$EDIT_DIR/'"
  cp "$file_path" "$EDIT_DIR/"

  # Define the path to the copied file in the edit directory
  edit_file_path="$EDIT_DIR/$filename"

  # Render the qmd file to docx using Quarto.
  # The output .docx file will be placed in the 'edit' directory.
  echo "  -> Rendering to .docx format"
  quarto render "$edit_file_path" --to docx

  # Remove the source .qmd file from the edit directory
  echo "  -> Removing source file from '$EDIT_DIR/'"
  rm "$edit_file_path"

  echo "  -> Done."
  echo ""
done

echo "All chapter files have been processed and rendered in the '$EDIT_DIR' directory." 