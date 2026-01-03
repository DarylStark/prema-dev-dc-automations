#!/bin/bash

SOURCE_FILE=$1
OUTPUT_FILE=$2

TEMPLATES_FOLDER=/home/developer/templates

typst compile \
    "$SOURCE_FILE" \
    "$OUTPUT_FILE"
