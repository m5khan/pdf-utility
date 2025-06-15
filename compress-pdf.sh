#!/bin/bash

# Usage: ./compress-pdf.sh input.pdf output.pdf

INPUT="$1"

if [[ -z "$INPUT" ]]; then
  echo "Usage: $0 input.pdf"
  exit 1
fi

docker run --rm -v "$(pwd)":/data ghostscript-image \
pdfcompress "/data/$INPUT"