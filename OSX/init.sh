#!/bin/bash

# Note: Run as sudo
# Note: Run in current shell

echo "DEBUG: Running OSX/init.sh"

# Show hidden files by default
# https://knowledge.autodesk.com/support/smoke/troubleshooting/caas/sfdcarticles/sfdcarticles/How-to-view-hidden-system-folders-in-Mac-OS-X-s.html
defaults write com.apple.Finder AppleShowAllFiles YES

# Set default terminal to Bash
chsh -s /bin/bash


# Installs latest version of make
# Note: installs as gmake, as per Brew instructions add to PATH
if ! command -v gmake &> /dev/null
then
    echo -e "\n####################\nInstalling gmake (make)\n##########"
    /opt/homebrew/bin/brew install make
    # pass this up to parent to add to bash_profile set PATH command
    BASH_PREFIXES=$BASH_PREFIXES"/usr/local/opt/make/libexec/gnubin:"
fi

# GNU coreutils tools, e.g. includes shuf
# Installs commands with 'g' prefix, call regular names with PATH modification
# https://formulae.brew.sh/formula/coreutils
# PATH entry: /opt/homebrew/opt/coreutils/libexec/gnubin/
if [ ! -d /opt/homebrew/opt/coreutils/ ]
then
    echo -e "\n##########\nInstalling coreutils\n##########"
    brew install coreutils && \
    PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
fi

# Path entry: /opt/homebrew/Cellar/wget/1.21.3/bin/
if ! command -v wget &> /dev/null
then
    echo -e "\n##########\nInstalling wget\n##########"
    brew install wget && \
    echo -e "\n##########\nWARNING: Verify wget install location and add to PATH: /opt/homebrew/Cellar/wget/1.21.3/bin/\n##########"
fi
