#!/bin/bash

IMAGE_NAME="pdf-util"
MOUNT_DIR="$(pwd)"

# Prompt the user
echo "Choose an action:"
echo "1. Compress PDF"
echo "2. Resize PDF",
echo "3. Merge PDFs"
read -p "Enter 1, 2 or 3: " choice

# Handle user input
case "$choice" in
  1)
    read -p "Enter input PDF filename: " input
    read -p "Enter output compressed filename: " output
    docker run --rm -v "$MOUNT_DIR":/data "$IMAGE_NAME" \
      bash -c "pdfcompress data/$input data/$output"
    echo "Compressed PDF saved as $output"
    ;;
  2)
    read -p "Enter input PDF filename: " input
    read -p "Enter output compressed filename: " output
    docker run --rm -v "$MOUNT_DIR":/data "$IMAGE_NAME" \
      bash -c "pdfresize data/$input data/$output"
    echo "Resized PDF saved as $output"
    ;;
  3)
    read -p "Enter input PDF filenames separated by spaces: " -a inputs
    read -p "Enter output merged filename: " merged
    input_args=""
    for f in "${inputs[@]}"; do
      input_args+=" /data/$f"
    done
    docker run --rm -v "$MOUNT_DIR":/data "$IMAGE_NAME" \
      bash -c "pdfunite $input_args /data/$merged"
    echo "Merged PDF saved as $merged"
    ;;
  *)
    echo "Invalid choice. Please enter 1 or 2."
    exit 1
    ;;
esac