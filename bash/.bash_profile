# Bash prompt
export PS1='\[\033[01;32m\]\u \[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$ '


#############
# osx_profile
#############
# Silence "default interactive shell is now zsh" warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# PostgreSQL psql command
PSQL_PATH="/usr/local/Cellar/libpq/13.2/bin/"
if [[ -d $PSQL_PATH ]]
then
    export PATH="$PATH:$PSQL_PATH"
fi

# Enable git auto-completion - https://apple.stackexchange.com/a/336997
[ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

# Default to Python 3
alias 'python=python3'
alias 'pip=pip3'
alias 'python-config=python3-config'
alias 'pydoc=pydoc3'


############
# go_profile
############
# For convenience
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
export GOPRIVATE="github.com/kohofinancial"
export GO111MODULE=on  # for enabling Go Modules on older Go versions

export PATH="$PATH:$GOPATH/bin"
# For multiple go versions
#alias 'go=go<version>'


##############
# KOHO Profile
##############
. ~/.profiles/.koho_profile

# Project-specific environments
#currentProject="helloworld"
if [ "$currentProject" == "helloworld" ]
then
    cd $GOPATH/src/github.com/bruce-koho/helloworldservice
fi
