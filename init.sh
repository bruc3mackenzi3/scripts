#!/bin/bash

scripts_path=$(pwd)

# Run system-specific initialization
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    OSX/init.sh
fi

# Create ~/.bash_profile pointing to custom .bash_profile
echo -e ". ${scripts_path}/Bash/.bash_profile \n. ${scripts_path}/Bash/.bash_aliases" > ~/.bash_profile
chmod a+x ~/.bash_profile
