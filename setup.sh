#!/bin/bash

# install tools

cp dot.code-special.sh ~/.code-special.sh

bash code.sh
sudo apt -y install dmidecode
sudo apt -y install apt-utils
sudo apt -y install lsof
sudo apt -y install rsync
sudo apt -y install gnome-keyring
sudo apt -y install python3-pip
pip3 install python-dotenv
sudo apt -y install jq
# sudo apt -y install lxterminal
