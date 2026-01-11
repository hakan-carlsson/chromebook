#!/bin/bash

Mailaddress=${1-"your@mail.address"}
Username=${2-"Your Name"}

. setup.env

# make sure we are in the repo dir
cd $(dirname $0) && {

  # install favorite tools
  install_if_missing apt-utils lsof rsync strace gnome-keyring jq bc btop tmux
  # sudo apt-get -y install tilix	# not working well on chrombook, use huge amount of cpu
  install_if_missing xterm	# use instead of tilix for now... Old style :-)
  install_if_missing wireshark iftop dnsutils traceroute tcpdump netcat-openbsd nodejs docker.io docker-compose
  sudo usermod -a -G docker ${USER}

  install_if_missing libssl-dev python3-pip python3-elasticsearch python3-dotenv python3-prison cmake python3-colorama
  # pip3 install azure-eventhub

  install_if_missing libswitch-perl libcommon-sense-perl libnumber-format-perl

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

  # remove Python Stuff if it exists
  PYStart="Python Stuff to make life easier"
  PYEnd="Python Stuff ends here"
  sed -i -e "/^# ${PYStart}/,/# ${PYEnd}/d" ~/.bashrc

  # add Python Stuff at end
  echo "# ${PYStart}" >> ~/.bashrc
  cat >> ~/.bashrc << E_O_F
# stop stupid python from creating__pycache__
export PYTHONDONTWRITEBYTECODE=1
E_O_F
  echo "# ${PYEnd}" >> ~/.bashrc

  # add .code-special, manually add to .bashrc
  cp dot.code-special.sh ~/.code-special.sh
}
