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
pandoc \
    $TEMPLATES_FOLDER/metadata.md \
    *.md \
    -o $OUTPUT_FILE \
    --pdf-engine=xelatex \
    --toc \
    --template=$TEMPLATES_FOLDER/eisvogel/eisvogel.latex \
    --lua-filter=$TEMPLATES_FOLDER/chapter-pagebreak.lua \
    --metadata title="$TITLE" \
    --metadata subtitle="$SUBTITLE" \
    --metadata date="$DATE" \
    --metadata author="$AUTHOR" \
    --metadata institute="$INSTITUTE" \
    --metadata=titlepage-background:"$TEMPLATES_FOLDER/front-page.png"
