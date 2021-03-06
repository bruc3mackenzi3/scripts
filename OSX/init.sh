#!/bin/bash

# Note: Run as sudo
# Note: Run in current shell

echo "DEBUG: Running OSX/init.sh"

# Show hidden files by default
# https://knowledge.autodesk.com/support/smoke/troubleshooting/caas/sfdcarticles/sfdcarticles/How-to-view-hidden-system-folders-in-Mac-OS-X-s.html
defaults write com.apple.Finder AppleShowAllFiles YES


# Installs lateste version of make
# Note: installs as gmake, as per Brew instructions add to PATH
if ! command -v gmake &> /dev/null
then
    brew install make
    # pass this up to parent to add to bash_profile set PATH command
    BASH_PREFIXES=$BASH_PREFIXES"/usr/local/opt/make/libexec/gnubin:"
fi
