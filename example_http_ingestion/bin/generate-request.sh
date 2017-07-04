#!/bin/bash
TMP_DIR=/tmp/kylo_example_http_ingestion
FILE_NAME="image_$(date +%s).jpg"
FQ_FILE_PATH="${TMP_DIR}/${FILE_NAME}"
mkdir -p ${TMP_DIR}
wget -O ${FQ_FILE_PATH} http://lorempixel.com/640/480/animals
curl -v -H "Filename=\"${FILE_NAME}\"" --data-binary "@${FQ_FILE_PATH}" http://localhost:9123/contentListener
