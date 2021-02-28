# Bash prompt
export PS1='\[\e[0;34m\][\u \W]$ \[\e[0m\]'


############
# osx_profile
#############
# Silence "default interactive shell is now zsh" warning
export BASH_SILENCE_DEPRECATION_WARNING=1

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

# For multiple go versions
#export PATH="$PATH:$GOPATH/bin"
#alias 'go=go<version>'


##############
# KOHO Profile
##############
# Koho API stuff
# For fixing Docker when it's in a bad state
alias d_nuke='docker kill $(docker ps -q); docker container prune -f && docker rmi -f $(docker images -qa) && docker volume prune -f && docker network prune -f'
alias d_logs='docker logs -n 10 -f koho_accounts-api_1 | jq .msg'

# Print available AWS Role Profiles
alias 'aws_profiles=egrep "^\[.+\]$" ~/.aws/config | awk -F"[\\\\[\\\\]]" "{print \$2}" | awk -F" " "{print \$NF}"'

alias 'ap=aws_profiles'
alias 'aap=aws_assume_profile'
alias 'pgp=get_pg_password'

# Project-specific environments
#currentProject="helloworld"
if [ "$currentProject" == "helloworld" ]
then
    cd $GOPATH/src/github.com/bruce-koho/helloworldservice
fi
