#!/bin/bash

Mailaddress=${1-"your@mail.address"}
Username=${2-"Your Name"}

. setup.env

# make sure we are in the repo dir
cd $(dirname $0) && {

# install favorite tools
install_if_missing apt-utils
install_if_missing lsof
install_if_missing rsync
install_if_missing strace
install_if_missing gnome-keyring
install_if_missing jq
install_if_missing bc
# sudo apt-get -y install tilix	# not working well on chrombook, use huge amount of cpu
install_if_missing xterm	# use instead of tilix for now... Old style :-)
install_if_missing wireshark
install_if_missing iftop
install_if_missing dnsutils
install_if_missing traceroute
install_if_missing tcpdump
install_if_missing netcat-openbsd
install_if_missing nodejs
install_if_missing docker.io
sudo usermod -a -G docker ${USER}
install_if_missing docker-compose

install_if_missing libssl-dev
install_if_missing python3-pip
install_if_missing python3-elasticsearch
install_if_missing python3-dotenv
install_if_missing python3-prison
install_if_missing cmake
# pip3 install azure-eventhub
install_if_missing python3-colorama

# setup apt channel for vs code and install
bash add_vs_code.sh

# setup dotnet 6.0
# bash add_dotnet.sh

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
