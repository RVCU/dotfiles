# .bashrc

user="$(whoami)"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export PATH=$PATH:~/bin
# User specific aliases and functions
alias tmux='tmux -2'
alias vim='nvim'
alias ll='ls -l'
alias sl='ls'
HISTSIZE=50000
HISTFILESIZE=100000
shopt -s histappend

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
[[ $- == *i* ]] && stty -ixon

