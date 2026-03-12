#!/bin/sh

# lf passes these arguments to the script automatically
FILE="$1"
WIDTH="$2"
HEIGHT="$3"

# Detect the file type
MIME=$(file -bL --mime-type "$FILE")

case "$MIME" in
    # If it is an image, render it with chafa to fit the preview column
    image/*)
        chafa --size="${WIDTH}x${HEIGHT}" "$FILE"
        ;;
    # If it is anything else (text, scripts), just output the text
    *)
        cat "$FILE"
        ;;
esac
