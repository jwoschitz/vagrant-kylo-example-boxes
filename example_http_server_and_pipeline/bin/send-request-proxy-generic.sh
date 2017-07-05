#!/bin/bash

usage() {
    SCRIPT_NAME="$0"
    echo "usage:"
    echo "$SCRIPT_NAME <image-url> "
    echo "image-url     :   the url to the image"
    echo ""
    echo "example:"
    echo "$SCRIPT_NAME http://healthsupple.org/images/burger.jpg"
    exit -1
}

if [[ $# -lt 1 ]]; then
    usage
fi

TMP_DIR=/tmp/kylo_example_http_ingestion
FILE_NAME="image_$(date +%s).jpg"
FQ_FILE_PATH="${TMP_DIR}/${FILE_NAME}"
mkdir -p ${TMP_DIR}
wget -O ${FQ_FILE_PATH} "$1"
curl -v -H "Filename=\"${FILE_NAME}\"" --data-binary "@${FQ_FILE_PATH}" http://localhost:9123/contentListener