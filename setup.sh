#!/bin/bash

# install tools

bash code.sh
sudo apt -y install dmidecode
sudo apt -y install apt-utils
sudo apt -y install lsof
sudo apt -y install rsync
sudo apt -y install gnome-keyring
sudo apt -y install python3-pip
pip3 install python-dotenv
sudo apt -y install jq
sudo apt -y install tilix


# add .code-special, manually add to .bashrc
cp dot.code-special.sh ~/.code-special.sh

# Add github config to ssh
if [ ! -r ~/.ssh/config ] ;then
    cat >> ~/.ssh/config << EOF

Host github.com
    HostName github.com
    IdentityFile ~/.ssh/github

EOF
