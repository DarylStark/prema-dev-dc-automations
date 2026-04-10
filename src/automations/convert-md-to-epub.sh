#!/bin/bash

SOURCE_FOLDER=$1
OUTPUT_FILE=$2

TEMPLATES_FOLDER=/home/developer/templates

cd $SOURCE_FOLDER

if [ -f settings.env ]; then
    set -e
    source settings.env
    set +e
fi

cd src
IFS=$'\n' read -rd '' -a FILES < <(find . -name "*md" -print0 | xargs -0 -n1 basename | sort | while read f; do find . -name "$f"; done && printf '\0')
printf '%s\n' "${FILES[@]}"

echo $FILES

pandoc \
    "${FILES[@]}" \
    -t epub3 \
    -o "$OUTPUT_FILE" \
    --css "$TEMPLATES_FOLDER/epub.css" \
    --toc \
    --metadata title="$TITLE" \
    --metadata subtitle="$SUBTITLE" \
    --metadata date="$DATE" \
    --metadata author="$AUTHOR" \
    --metadata institute="$INSTITUTE"
