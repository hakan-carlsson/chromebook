#!/bin/bash

if false; then
	# not working yet (no detnet for arm64?)
	wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	rm packages-microsoft-prod.deb

	sudo apt-get update; \
  	sudo apt-get install -y apt-transport-https && \
  	sudo apt-get update && \
  	sudo apt-get install -y dotnet-sdk-6.0

	sudo apt-get install -y dotnet-runtime-6.0
else


	# Manual install

	cd ~ && {

		# might need to go to https://dotnet.microsoft.com/en-us/download/dotnet/6.0 and click arm64 to get the file

		Version="6.0.202"
		curl -qLRO https://download.visualstudio.microsoft.com/download/pr/952f5525-7227-496f-85e5-09cadfb44629/eefd0f6eb8f809bfaf4f0661809ed826/dotnet-sdk-${Version}-linux-arm64.tar.gz

		DOTNET_FILE=dotnet-sdk-${Version}-linux-arm64.tar.gz
		export DOTNET_ROOT=$(pwd)/.dotnet
		mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_FILE" -C "$DOTNET_ROOT"
		# export PATH=$PATH:$DOTNET_ROOT
		ln -s ${DOTNET_ROOT}/dotnet ~/.local/bin/dotnet

		rm -f dotnet-sdk-${Version}-linux-arm64.tar.gz

	}

fi
