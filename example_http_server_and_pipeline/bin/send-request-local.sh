#!/bin/bash

usage() {
    SCRIPT_NAME="$0"
    echo "usage:"
    echo "$SCRIPT_NAME <image-path> "
    echo "image-path     :   the path to the image"
    echo ""
    echo "example:"
    echo "$SCRIPT_NAME images/cat_a.jpg"
    exit -1
}

if [[ $# -lt 1 ]]; then
    usage
fi

curl -v --data-binary "@$1" http://localhost:9123/contentListener