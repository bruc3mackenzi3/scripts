_print_debug "Entering aliases.sh ..."

# Shell aliases
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias la='ls -A'
alias ll='ls -l'

alias 'pyjson=python -m json.tool'
alias 'mkcd=. mkcd'
alias 'cdrm=. cdrm'


# Git aliases
alias 'gst=git status'
alias 'gbr=git branch'
alias 'gco=git checkout'
alias 'gad=git add'
alias 'gci=git commit'
alias 'gdf=git diff'
alias 'gpl=git pull'
alias 'gpsh=git push'
alias 'glg=git log'
alias 'gsl=git stash list'
alias 'gsp=git stash pop'
alias 'gitcp=git cherry-pick'
alias 'git_recent=git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)"'

# Shortform aliases
alias 'd=docker'
alias 'dc=docker compose'
alias 'g=git'
alias 'k=kubectl'
alias 'm=make'
alias 'py=python3'

alias "dname=docker ps --format '{{.Names}}' | sort"  # list only names of Docker containers
alias "dps=docker ps --format '{{.Names}} {{.Ports}}' | sort"  # names & ports
# For fixing Docker when it's in a bad state
alias 'dnuke=docker kill $(docker ps -q); docker container prune -f && docker rmi -f $(docker images -qa) && docker volume prune -f && docker network prune -f'

_print_debug "... exiting aliases.sh"
