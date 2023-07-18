_DEBUG=off
function _print_debug() {
    if [ "$_DEBUG" == "on" ]; then
        echo $@
    fi
}
_print_debug "Entering main_profile.sh ..."

############
# Global Profile
############
# Bash prompt
export PS1='\[\033[01;32m\]\u \[\033[00m\]\[\033[01;34m\]\W\[\033[00m\]\$ '
export CLICOLOR=1  # enables color output for ls command

. ~/.profiles/quickplay_profile.sh
. ~/.profiles/aliases.sh

# Executable paths to prepend and append to PATH
_PATH_PREFIX=":"  # always end with :
_PATH_SUFFIX=":$HOME/bin"  # always begin with :
export PATH=$_PATH_PREFIX$PATH$_PATH_SUFFIX


#############
# OSX profile
#############
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    # Silence "default interactive shell is now zsh" warning
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Enable git auto-completion - https://apple.stackexchange.com/a/336997
    [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

    # Path entries
    _PATH_PREFIX="/opt/homebrew/opt/coreutils/libexec/gnubin/:"  # always end with :
    _PATH_SUFFIX=":/opt/homebrew/bin/:"  # always begin with :
    _PATH_SUFFIX=$_PATH_SUFFIX":/opt/homebrew/opt/libpq/bin"
    export PATH=$_PATH_PREFIX$PATH$_PATH_SUFFIX
fi


############
# WSL Profile
############
if [[ -n $WSLENV ]]; then
    export WHOME="/mnt/c/Users/BMacK/"
fi


############
# Go profile
############
#export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="/Users/brucem/sdk/go1.19.4/bin/:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"

# Switch to non-default version
#alias 'go=go1.19.4'  # /Users/brucem/sdk/go1.19.4/bin/go
# alias 'go=go1.15.15'

if [ -n "$GOPRIVATE" ]
then
    _OLD_GOPRIVATE="$GOPRIVATE,"
fi
export GOPRIVATE="${_OLD_GOPRIVATE}\
github.com/bruc3mackenzi3"

go_versions=$(cd ~/go/bin/ && ls go*.*)
echo -e \\nNOTE: Current active Go version is $(go version)\\nOther Go versions available: $go_versions\\n


########
# Python
########
# Enable Python virtual environment, creating first if it doesn't exist
function enable_python_venv {
    env_path="/c/Users/BMacK/.virtualenvs/default_env"
    if [ ! -d $env_path ]; then
        py -m venv $env_path
    fi
    source "$env_path/Scripts/activate"
    echo "NOTE: Enabled Python virtual environment"
}


####################
# Kubernetes Profile
####################
alias 'k=kubectl'

# Enable autocompletion
source <(kubectl completion bash | sed s/kubectl/k/g)


####
# Helpers
####
# b64 provides a convenient interface for base64 ENCODING text with the command of the same
base() {
    # $@ copies positional parameters verbatim
    echo -n $@ | base64
}

# b64d provides a convenient interface for base64 DECODING text with the command of the same
based() {
    for arg in $@
    do
        echo -n $arg | base64 -d
        echo -e
    done
}

# mkdir followed by cd
mkcd() {
    # check for arguments passed
    if [ $# -ne 1 ]; then
        echo "mkcd: missing folder name" 1>&2
        echo "Usage: mkcd FOLDER" 1>&2
        echo "Create a folder and cd to it in one command" 1>&2
    else
        mkdir $1
        cd $1
    fi
}



####
# Cleanup
####
_print_debug "... exiting main_profile.sh"
unset _DEBUG
unset _print_debug
unset _PATH_PREFIX
unset _PATH_SUFFIX
unset _OLD_GOPRIVATE
