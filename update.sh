#!/bin/bash
set -e
rm -rf local/*
sudo docker build .
# sudo docker run -it --rm -v ./config:/root/.config -v ./local:/root/.local $(sudo docker build -q .)
sudo docker run -it --rm -v ./config:/root/.config -v ./local:/root/.local $(sudo docker build -q .) nvim --headless -c "Lazy update" -c "sleep 120" -c "qa"
sudo chown -R $(whoami) local
sudo chown -R $(whoami) config
rm -rf $(find local -name .git) # remove git repos which have appeared in local
