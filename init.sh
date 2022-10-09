#!/bin/bash

# Note: Run from repo root directory
# Note: May require running as sudo for copying to /usr/local/bin

# Executable paths to prepend and append to PATH
PATH_PREFIX=""  # always end with :
PATH_SUFFIX=""  # always begin with :

# Run system-specific initialization
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    . OSX/init.sh
fi

# copy files to home directory; NOTE this overwrites previous copy
mkdir -p ~/.profiles/ && cp bash/* ~/.profiles/
cp bin/* /usr/local/bin/

# Multiline string containing script we'll add to .bash_profile
read -r -d '' BASH_PROFILE << EOM
# NOTE: This was added by Bruce's environment initializer script.
# Changes to this file may be overwritten

export PATH=$PATH_PREFIX\$PATH$PATH_SUFFIX
. ~/.profiles/profile.sh
. ~/.profiles/aliases.sh
EOM

# Initialize ~/.bash_profile pointing to custom .bash_profile
CHOICE="none"
if [ -f ~/.bash_profile ]; then
    echo ".bash_profile exists. [o]verwrite, [a]ppend, [s]kip, or [c]ancel?"
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
elif [[ $CHOICE == "s" ]]; then
    echo "Skipping"
else
    1>&2 echo "Error: invalid option $CHOICE"
    exit 1
fi
chmod a+x ~/.bash_profile

cp common/.vimrc ~/

####
# Configure git
####
git config --global user.email "mackenzbb@gmail.com"
git config --global user.name "Bruce MacKenzie"

# Default to ssh instead of HTTPS
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"

# Disable merge on pull
git config --global pull.ff only

# Set global gitignote
git config --global core.excludesfile ~/.gitignore_global

# SSH
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Warning: SSH private key file missing.  You may need to setup SSH keys."
fi
