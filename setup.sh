#!/bin/bash

Mailaddress=${1-"your@mail.address"}
Username=${2-"Your Name"}

# make sure we are in the repo dir
cd $(dirname $0) && {

# install favorite tools
sudo apt -y install apt-utils
sudo apt -y install lsof
sudo apt -y install rsync
sudo apt -y install strace
sudo apt -y install gnome-keyring
sudo apt -y install jq
sudo apt -y install bc
# sudo apt -y install tilix	# not working well on chrombook, use huge amount of cpu
sudo apt -y install xterm	# use instead of tilix for now... Old style :-)
sudo apt -y install wireshark
sudo apt -y install iftop
sudo apt -y install dnsutils
sudo apt -y install traceroute
sudo apt -y install tcpdump
sudo apt -y install netcat
sudo apt -y install nodejs
sudo apt -y install moby-engine
sudo usermod -a -G docker ${USER}
sudo apt -y install docker-compose

sudo apt -y install libssl-dev
sudo apt -y install python3-pip
pip3 install elasticsearch
pip3 install python-dotenv
pip3 install prison
sudo apt -y install cmake
pip3 install azure-eventhub
pip3 install colorama

# setup apt channel for vs code and install
bash add_vs_code.sh

# setup dotnet 6.0
bash add_dotnet.sh

# setup az commands
#
# https://docs.microsoft.com/sv-se/cli/azure/install-azure-cli-linux?pivots=apt
# bash add_az.sh			# only works for amd64
# bash add_az_manually.sh		# changed to add for arm64

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
  case "$TERM" in
  xterm*|rxvt*)
    PROMPT_COMMAND="__git_ps1 '\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]\u@\h:\w' '\\$ '" ;;
  *)
    PROMPT_COMMAND="__git_ps1 '\u@\h:\w' '\\$ '" ;;
  esac
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
