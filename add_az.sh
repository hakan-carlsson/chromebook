#!/bin/bash

Brave=false

if ${Brave} ;then
    # one step if you are brave :-)
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

else

# or check the script first (and change to arm64)
    curl -sL https://aka.ms/InstallAzureCLIDeb | sed 's/amd64/arm64/g' > add_az_script.sh
    less add_az_script.sh
    echo 'Ok to install? '
    read answer < /dev/tty
    if [ "$answer" = "yes" ] ;then
        sudo bash add_az_script.sh
    fi
fi
