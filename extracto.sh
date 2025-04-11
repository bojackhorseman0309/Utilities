#!/bin/bash

# run ./script ./directory to process

# Directory to process, defaults to the current directory if not provided
TARGET_DIR="${1:-.}"

# Iterate through all folders in the target directory
for folder in "$TARGET_DIR"/*; do
  if [ -d "$folder" ]; then
    echo "Processing folder: $folder"
    
    # Iterate through the files and subdirectories in the folder
    for item in "$folder"/*; do
      # Get the base name of the item
      base_name=$(basename "$item")

      # Check if an item with the same name already exists in the parent directory
      if [ -e "$TARGET_DIR/$base_name" ]; then
        # Append a timestamp to the file/folder name to avoid overwriting
        new_name="${base_name%.*}_$(date +%s).${base_name##*.}"
        mv "$item" "$TARGET_DIR/$new_name"
        echo "Moved and renamed: $item -> $TARGET_DIR/$new_name"
      else
        mv "$item" "$TARGET_DIR/"
        echo "Moved: $item -> $TARGET_DIR/"
      fi
    done

    # Remove the now-empty folder
    rmdir "$folder"
    echo "Removed folder: $folder"
  fi
done

echo "Completed processing all folders in $TARGET_DIR"
