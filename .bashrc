export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# http://jafrog.com/2013/11/23/colors-in-terminal.html
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
COLOR_CYAN='\e[36;1m'
COLOR_GREEN='\e[32;1m'
COLOR_YELLOW='\e[33;1m'
COLOR_RED='\e[91;1m'
COLOR_NONE='\e[0m'

PS1_USERNAME="\[$COLOR_CYAN\]\u"
PS1_AT="\[$COLOR_NONE\]@"
PS1_HOST="\[$COLOR_GREEN\]\h"
PS1_COLON="\[$COLOR_NONE\]:"
PS1_CURRENTDIR="\[$COLOR_YELLOW\]\w"
PS1_UID="\[$COLOR_NONE\]\$"
PS1_GITBRANCH="\[$COLOR_RED\]\$(parse_git_branch)"
export PS1="$PS1_USERNAME$PS1_AT$PS1_HOST$PS1_COLON$PS1_CURRENTDIR$PS1_GITBRANCH$PS1_UID "

alias ls="ls -p"
alias ll="ls -lahp"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias vi="vim"
alias mkcd="mkdir $1 && cd $1"
alias scala="scala -Dscala.color"

docker-ssh() {
  docker exec -i -t $1 sh
}

docker-update-time() {
  docker run --rm --privileged --pid=host walkerlee/nsenter -t 1 -m -u -i -n ntpd -d -q -n -p `cat /etc/ntp.conf | awk '{ print $2 }'`
}

docker-cleanup-volumes() {
  docker volume rm `docker volume ls -q -f dangling=true`
}

docker-cleanup-images() {
  docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
}

git-pull-allsubdirs() {
  find . -maxdepth 1 -type d \( ! -name . \)  -exec sh -c -c '(cd {} && pwd && git pull)' ';'
}
