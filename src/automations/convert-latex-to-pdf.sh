#!/bin/bash

SOURCE_FILE=$1
OUTPUT_DIRECTORY=$2``

TEMPLATES_FOLDER=/home/developer/templates

pdflatex \
    --output-format=pdf \
    --output-directory="${OUTPUT_DIRECTORY}" \
    "$SOURCE_FILE"
