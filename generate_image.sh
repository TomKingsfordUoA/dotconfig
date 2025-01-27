#!/bin/bash

# Check for untracked files - this will throw off the version number:
# Colon is only present for untracked files, changes to be committed, ...
if git status | grep ":" >/dev/null; then
  echo "Untracked or uncommitted files present... Please commit or stash them first"
  exit -1
fi

OUTPUT_DIR="dist"
OUTPUT_FILE=$(git rev-parse --short HEAD).
mkdir -p $OUTPUT_DIR
sudo docker build .
sudo docker image save $(sudo docker build -q .) >$OUTPUT_DIR/$OUTPUT_FILE.tar
cd $OUTPUT_DIR
tar -czvf $OUTPUT_FILE.tgz $OUTPUT_FILE.tar
