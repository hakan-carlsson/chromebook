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

		Version="6.0.301"
		# curl -q -sLRO https://download.visualstudio.microsoft.com/download/pr/06c4ee8e-bf2c-4e46-ab1c-e14dd72311c1/f7bc6c9677eaccadd1d0e76c55d361ea/dotnet-sdk-${Version}-linux-arm64.tar.gz

		# SDK
		DOTNET_FILE=dotnet-sdk-${Version}-linux-arm64.tar.gz
		export DOTNET_ROOT=$(pwd)/.dotnet
		mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_FILE" -C "$DOTNET_ROOT"
		ln -sf ${DOTNET_ROOT}/dotnet ~/.local/bin/dotnet
		rm -f dotnet-sdk-${Version}-linux-arm64.tar.gz

		# Runtime
		Version="3.1.26"
		# https://download.visualstudio.microsoft.com/download/pr/cb0e8b4b-7b2b-40cc-b7a6-30f0d4fabe6c/f5cb06cbb1b1b5d198792333b3db235a/dotnet-runtime-${Version}-linux-arm64.tar.gz
		DOTNET_FILE=dotnet-runtime-${Version}-linux-arm64.tar.gz
		mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_FILE" -C "$DOTNET_ROOT"
		rm -f dotnet-runtime-${Version}-linux-arm64.tar.gz

	}

fi
