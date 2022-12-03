#!/bin/bash

# Note: Run from repo root directory
# Note: May require running as sudo for copying to /usr/local/bin

# Multiline string containing script we'll add to .bashrc
read -r -d '' BASHRC << EOM
################################################
# NOTE: Below section added by Bruce's environment initializer script.
# Changes to this file may be overwritten
. ~/.profiles/main_profile.sh
EOM

####
# Step 1 - Run system-specific initialization
####
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    . OSX/init.sh
fi

####
# Step 2 - Deploy files
####
# copy files to home directory; NOTE this overwrites previous copy
mkdir -p ~/.profiles/ && cp bash/* ~/.profiles/
mkdir -p $HOME/bin/ && cp bin/* $HOME/bin/

cp common/.gitignore_global common/.vimrc ~/

####
# Step 3 - Link .bashrc to custom profiles
####
read -r -d '' BASHRC << EOM
$BASHRC

# End of automated environment initialization
################################################
EOM

# Initialize ~/.bashrc pointing to custom .bashrc
if grep -q "NOTE: Below section added by Bruce's environment initializer script" ~/.bashrc; then
    echo ".bashrc already linked to custom environment; skipping"
else
    CHOICE="none"
    if [ -f ~/.bashrc ]; then
        echo ".bashrc exists. [o]verwrite, [a]ppend, or [c]ancel?"
        read CHOICE
    fi

    if [[ $CHOICE == "c" ]]; then
        exit 1
    elif [[ $CHOICE == "o" || $CHOICE == "none" ]]; then
        cat > ~/.bashrc <<- EOM
$BASHRC
EOM
    elif [[ $CHOICE == "a" ]]; then
        cat >> ~/.bashrc <<- EOM
$BASHRC
EOM
    else
        1>&2 echo "Error: invalid option $CHOICE"
        exit 1
    fi
    chmod a+x ~/.bashrc
fi


####
# Step 4 - Configure git
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
if [ ! -f ~/.ssh/id_rsa ] && [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "Warning: SSH private key file missing.  You may need to setup SSH keys."
fi
