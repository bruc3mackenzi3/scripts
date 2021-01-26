#!/bin/bash

# Note: Run from repo root directory

scripts_path=$PWD

# Run system-specific initialization
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    OSX/init.sh
fi

# Create ~/.bash_profile pointing to custom .bash_profile
cat > ~/.bash_profile <<- EOM
export PATH=$PATH:${scripts_path}/bin
. ${scripts_path}/Bash/.bash_profile
. ${scripts_path}/Bash/.bash_aliases
EOM
chmod a+x ~/.bash_profile

cp common/.vimrc ~/
