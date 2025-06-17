#!/bin/bash

IMAGE_NAME="ghostscript-image"
MOUNT_DIR="$(pwd)"

# Prompt the user
echo "Choose an action:"
echo "1. Compress PDF using Ghostscript"
echo "2. Merge PDFs using pdfunite"
read -p "Enter 1 or 2: " choice

# Handle user input
case "$choice" in
  1)
    read -p "Enter input PDF filename: " input
    read -p "Enter output compressed filename: " output
    docker run --rm -v "$MOUNT_DIR":/data "$IMAGE_NAME" \
      gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
      -dNOPAUSE -dQUIET -dBATCH \
      -sOutputFile="/data/$output" "/data/$input"
    echo "✅ Compressed PDF saved as $output"
    ;;
  2)
    read -p "Enter input PDF filenames separated by spaces: " -a inputs
    read -p "Enter output merged filename: " merged
    input_args=""
    for f in "${inputs[@]}"; do
      input_args+=" /data/$f"
    done
    docker run --rm -v "$MOUNT_DIR":/data "$IMAGE_NAME" \
      sh -c "pdfunite $input_args /data/$merged"
    echo "✅ Merged PDF saved as $merged"
    ;;
  *)
    echo "❌ Invalid choice. Please enter 1 or 2."
    exit 1
    ;;
esac