#!/bin/bash

# Note: Run from repo root directory

scripts_path=$PWD

# Run system-specific initialization
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    OSX/init.sh
fi

ln -s $scripts_path/bash/ ~/.profiles

# Create ~/.bash_profile pointing to custom .bash_profile
cat > ~/.bash_profile <<- EOM
export PATH=\$PATH:${scripts_path}/bin
. ~/.profiles/.bash_profile
. ~/.profiles/.bash_aliases
EOM
chmod a+x ~/.bash_profile

cp common/.vimrc ~/

# Configure git
git config --global pull.ff only
