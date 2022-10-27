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
export PATH="/home/$USER/go/bin:$PATH"  # GOPATH

# For multiple go versions add / toggle the GOROOT added to PATH
#export PATH="/usr/local/go1.15.15/bin/:$PATH"  # GOROOT
export PATH="/usr/local/go-1.19/bin/:$PATH"  # GOROOT
echo -e "\nNOTE: Current active Go version is $(go version)\n"

export GOPRIVATE="github.com/bruc3mackenzi3"
