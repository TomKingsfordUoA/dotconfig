#!/bin/bash
set -e
sudo docker build .
sudo docker run -it --rm -v ~/projects:/root/projects $(sudo docker build -q .)
