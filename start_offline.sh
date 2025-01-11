#!/bin/bash
set -e
sudo docker build .
sudo docker run -it --rm --network none -v ~/projects:/root/projects $(sudo docker build -q .)
