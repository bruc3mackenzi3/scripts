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

    # PostgreSQL psql command
    PSQL_PATH="/usr/local/Cellar/libpq/13.2/bin/"
    if [[ -d $PSQL_PATH ]]
    then
        export PATH="$PATH:$PSQL_PATH"
    fi

    # Enable git auto-completion - https://apple.stackexchange.com/a/336997
    [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

########
# Python
########
# Default to Python 3
alias 'python=python3'
alias 'pip=pip3'
alias 'python-config=python3-config'
alias 'pydoc=pydoc3'

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
# For multiple go versions
# export PATH="/usr/local/go/bin:$PATH"  # go1.15.12
#export PATH="/Users/bruce/sdk/go1.17.2/bin/:$PATH"

export GOPRIVATE="github.com/bruc3mackenzi3"

# For convenience
# Note: including these was breaking the environment, causing mismatched Go versions
# export GOPATH=$(go env GOPATH)
# export GOROOT=$(go env GOROOT)
# export PATH="$PATH:$GOPATH/bin"
# export GO111MODULE=on  # for enabling Go Modules on older Go versions
