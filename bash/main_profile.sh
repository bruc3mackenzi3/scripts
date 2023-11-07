_DEBUG=off
function _print_debug() {
    if [ "$_DEBUG" == "on" ]; then
        echo $@
    fi
}
_print_debug "Entering main_profile.sh ..."


#############
# OSX profile
#############
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    # Silence "default interactive shell is now zsh" warning
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Enable git auto-completion - https://apple.stackexchange.com/a/336997
    [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

    [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

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
# Global Profile
############
# Bash prompt
# Reference: https://brettterpstra.com/2009/11/17/my-new-favorite-bash-prompt/
prompt_command() {
    if [ $? -eq 0 ]; then # set an error string for the prompt, if applicable
        ERROR_PROMPT=""
    else
        ERROR_PROMPT='->($?) '
    fi

    # Note: this depends on git_prompt.sh being set in current environment
    if [ "\$(type -t __git_ps1)" ]; then # if we're in a Git repo, show current branch
        GIT_BRANCH="\$(__git_ps1 '(%s) ')"
    fi

    local DEFAULT="\[\033[0m\]"
    local RED="\[\033[0;31m\]"
    local PURPLE="\[\033[0;35m\]"
    local CYAN="\[\033[0;36m\]"
    local GRAY="\[\033[0;37m\]"
    local DARK_GRAY="\[\033[1;30m\]"
    local LIGHT_GREEN="\[\033[1;32m\]"
    local YELLOW="\[\033[1;33m\]"
    local LIGHT_BLUE="\[\033[1;34m\]"
    local LIGHT_CYAN="\[\033[1;36m\]"
    local WHITE="\[\033[1;37m\]"

    local GCLOUD_PROJECT="($(get_active_gcloud_project)) "

    export PS1="${LIGHT_GREEN}\u ${YELLOW}${GIT_BRANCH}${LIGHT_BLUE}${GCLOUD_PROJECT}${RED}${ERROR_PROMPT}${LIGHT_CYAN}\W${DEFAULT}\$ "
}
PROMPT_COMMAND=prompt_command

get_active_gcloud_project() {
    gcloud config configurations list --filter IS_ACTIVE=True | tail -1 | awk '{print $1}'
}

export CLICOLOR=1  # enables color output for ls command

. ~/.profiles/quickplay_profile.sh
. ~/.profiles/aliases.sh

# Executable paths to prepend and append to PATH
_PATH_PREFIX=":"  # always end with :
_PATH_SUFFIX=":$HOME/bin"  # always begin with :
export PATH=$_PATH_PREFIX$PATH$_PATH_SUFFIX


############
# Go profile
############
#export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="/Users/brucem/sdk/go1.20.6/bin/:$PATH"
#export PATH="/Users/brucem/sdk/go1.19.4/bin/:$PATH"
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
