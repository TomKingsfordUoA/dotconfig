#!/bin/bash

# Check for untracked files - this will throw off the version number:
# Colon is only present for untracked files, changes to be committed, ...
if git status | grep ":" >/dev/null; then
  echo "Untracked or uncommitted files present... Please commit or stash them first"
  exit -1
fi

OUTPUT_DIR="dist"
mkdir -p $OUTPUT_DIR
sudo docker build .
sudo docker image save $(sudo docker build -q .) >$OUTPUT_DIR/$(git rev-parse --short HEAD).tar
