#!/bin/bash

Mailaddress=${1-"your@mail.address"}
Username=${2-"Your Name"}

# make sure we are in the repo dir
cd $(dirname $0) && {

# install favorite tools
sudo apt -y install apt-utils
sudo apt -y install lsof
sudo apt -y install rsync
sudo apt -y install gnome-keyring
sudo apt -y install python3-pip
pip3 install python-dotenv
sudo apt -y install jq
sudo apt -y install tilix
sudo apt -y install wireshark
sudo apt -y install iftop
sudo apt -y install traceroute
sudo apt -y install nodejs
pip3 install prison

# setup apt channel for vs code and install
bash code.sh

# create .ssh/config if not exists
if [ ! -r ~/.ssh/config ] ;then
    cat >> ~/.ssh/config << E_O_F

Host github.com
    HostName github.com
    IdentityFile ~/.ssh/github

Host ssh.dev.azure.com
    Hostname ssh.dev.azure.com
    IdentityFile ~/.ssh/azure
    IdentitiesOnly yes

E_O_F
fi

# remove GIT Stuff if it exists
GITStart="GIT Stuff to make life easier"
GITEnd="GIT Stuff ends here"
sed -i -e "/^# ${GITStart}/,/# ${GITEnd}/d" ~/.bashrc

# add GIT Stuff at end
echo "# ${GITStart}" >> ~/.bashrc
cat >> ~/.bashrc << 'E_O_F'
if [ -f /usr/lib/git-core/git-sh-prompt ] ;then
  . /usr/lib/git-core/git-sh-prompt
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWCOLORHINTS=true
  GIT_PS1_UNTRACKEDFILES=true
  PROMPT_COMMAND="__git_ps1 '\u@\h:\w' '\\$ '"
fi
if [ -f /usr/share/bash-completion/completions/git ] ;then
  source /usr/share/bash-completion/completions/git
fi
E_O_F
echo "# ${GITEnd}" >> ~/.bashrc

# create .gitconfig if not exists
if [ ! -r ~/.gitconfig ] ;then
    cat >> ~/.gitconfig << E_O_F

[user]
	email = ${Mailaddress}
	name = ${Username}

[alias]
	co = checkout
	ci = commit
	st = status
	br = branch
	hist = log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
	type = cat-file -t
	dump = cat-file -p
E_O_F
fi


# add .code-special, manually add to .bashrc
cp dot.code-special.sh ~/.code-special.sh

}
