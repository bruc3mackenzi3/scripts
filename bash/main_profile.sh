# Bash prompt
export PS1='\[\033[01;32m\]\u \[\033[00m\]\[\033[01;34m\]\W\[\033[00m\]\$ '
export CLICOLOR=1  # enables color output for ls command


#############
# OSX profile
#############
env=$(uname)
if [[ "$env" == "Darwin" ]]; then
    # Silence "default interactive shell is now zsh" warning
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Enable git auto-completion - https://apple.stackexchange.com/a/336997
    [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

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


############
# Go profile
############
export PATH="$(go env GOPATH)/bin:$PATH"  # GOPATH, note: instead consider doing PATH="$(go env GOPATH)/bin:$PATH"

if [ -z "$GOPRIVATE" ]
then
    OLD_GOPRIVATE="$GOPRIVATE,"
fi
export GOPRIVATE="$OLD_GOPRIVATE\
github.com/bruc3mackenzi3"

# Switch to non-default version
#alias 'go=go1.19'
#alias 'go=go1.15'

echo -e "\nNOTE: Current active Go version is $(go version)\n"