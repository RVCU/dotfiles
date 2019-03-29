# .bashrc

user="$(whoami)"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# Source work functions
if [ -f /home/"$user"/.bash_work_functions ]; then
    . /home/"$user"/.bash_work_functions  
fi

# Setting default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export GOPATH=/home/"$user"/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin:/home/"$user"/bin
export GOBIN=$GOPATH/bin
# User specific aliases and functions


ne() {
    cd  /home/"$user"/Documents/notes/TODO && vim 
}
nls() {
    tree -t --dirsfirst -C /home/"$user"/Documents/notes/ | grep -i --color "$*"
}
worker() {

    for name in $(docker ps -a --format "{{.Names}}"| xargs) 
    do
        if [[ "$2" == "$name" ]]
        then
            exists=true
        fi
    done
    if [[ "$exists" ]]
    then 
        case $1 in
             -c)
                docker start "$2"; docker exec -it $2 bash
              ;;
             -l)
                docker ps -a | grep -E 'work_env'
              ;;
        esac
    else
        case $1 in
            -c)
                docker run -it -v M2:/home/"$user"/.m2/ -v ~/.ssh/:/home/"$user"/.ssh/:ro -v code:/home/"$user"/code_clean:ro --name "$2" work_env
              ;;
            -l)
                docker ps -a | grep -E 'work_env'
              ;;
        esac
    fi
}

how_in() {
    where="$1"; shift
    IFS=+ curl "https://cht.sh/$where/$*" 
} 


alias tmux='tmux -2'
HISTSIZE=50000
HISTFILESIZE=100000
shopt -s histappend

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

