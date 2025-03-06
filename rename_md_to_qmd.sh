#!/bin/bash
# This script renames all the .md files in the chapters folder to .qmd files.

for file in chapters/*.md; do
    # Generate the new filename by replacing the extension
    newfile="${file%.md}.qmd"
    echo "Renaming $file to $newfile"
    mv "$file" "$newfile"
done 