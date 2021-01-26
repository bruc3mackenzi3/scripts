# Bash prompt
export PS1='\[\e[0;34m\][\u \W]$ \[\e[0m\]'

osx_profile() {
    # Silence "default interactive shell is now zsh" warning
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Enable git auto-completion - https://apple.stackexchange.com/a/336997
    [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
}

go_profile() {
    # For convenience
    export GOPATH=$(go env GOPATH)
    export GOROOT=$(go env GOROOT)
    export GO111MODULE=on
    export GOPRIVATE="github.com/kohofinancial"
}

koho_profile() {
    # Koho API stuff
    # For fixing Docker when it's in a bad state
    alias d_nuke='docker kill $(docker ps -q) && docker container prune -f && docker rmi -f $(docker images -qa) && docker volume prune -f && docker network prune -f'
}

osx_profile
go_profile
koho_profile

# Project-specific environments
#currentProject="helloworld"
if [ "$currentProject" == "helloworld" ]
then
    cd $GOPATH/src/github.com/bruce-koho/helloworldservice
fi
