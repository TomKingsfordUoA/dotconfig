#/bin/bash

set -e
sudo docker build .
sudo docker save $(sudo docker build -q .) >nvim.tar
