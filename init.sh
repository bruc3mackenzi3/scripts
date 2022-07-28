#!/bin/bash

# Note: Run from repo root directory

echo "DEBUG: Running init.sh"

scripts_path=$PWD

# Executable paths to prepend and append to PATH
PATH_PREFIX=""  # always end with :
PATH_SUFFIX=":$HOME/bin/"  # always begin with :

# Run system-specific initialization
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    . OSX/init.sh
fi

# copy files to home directory; NOTE this overwrites previous copy
mkdir -p ~/.profiles/ && cp bash/* ~/.profiles/
cp bin/* ~/bin/

read -r -d '' BASH_PROFILE << EOM
export PATH=$PATH_PREFIX\$PATH$PATH_SUFFIX
. ~/.profiles/profile.sh
. ~/.profiles/aliases.sh
EOM

# Initialize ~/.bash_profile pointing to custom .bash_profile
CHOICE="none"
if [ -f ~/.bash_profile ]; then
    echo ".bash_profile exists. [o]verwrite, [a]ppend, or [c]ancel?"
    read CHOICE
fi

if [[ $CHOICE == "c" ]]; then
    exit 1
elif [[ $CHOICE == "o" || $CHOICE == "none" ]]; then
    cat > ~/.bash_profile <<- EOM
    $BASH_PROFILE
EOM
elif [[ $CHOICE == "a" ]]; then
    cat >> ~/.bash_profile <<- EOM
    $BASH_PROFILE
EOM
else
    1>&2 echo "Error: invalid option $CHOICE"
    exit 1
fi
chmod a+x ~/.bash_profile

cp common/.vimrc ~/

####
# Configure git
####
# Default to ssh instead of HTTPS
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"

# Disable merge on pull
git config --global pull.ff only

# Set global gitignote
git config --global core.excludesfile ~/.gitignore_global
