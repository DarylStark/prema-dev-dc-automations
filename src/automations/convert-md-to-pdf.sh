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

pandoc \
    "$TEMPLATES_FOLDER/metadata.md" \
    "${FILES[@]}" \
    -o "$OUTPUT_FILE" \
    --pdf-engine=xelatex \
    --toc \
    --template="$TEMPLATES_FOLDER/eisvogel/eisvogel.latex" \
    --lua-filter="$TEMPLATES_FOLDER/chapter-pagebreak.lua" \
    --metadata title="$TITLE" \
    --metadata subtitle="$SUBTITLE" \
    --metadata date="$DATE" \
    --metadata author="$AUTHOR" \
    --metadata institute="$INSTITUTE" \
    --metadata=titlepage-background:"$TEMPLATES_FOLDER/front-page.png"
