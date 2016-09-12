# If not running interactively, don't do anything
[ -z "$PS1" ] && return

set -o vi

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

if [ -x $(which dircolors) ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

[ -d "${HOME}/bin" ] && PATH=${HOME}/bin:${PATH}

# OS-specific items: anything that belongs only on the current OS
OS=$(uname|awk -F "(_|/|-)" '{print $1}'|tr "[:upper:]" "[:lower:]")
[ -f ~/.dotfiles/$OS.bashrc ] && . ~/.dotfiles/$OS.bashrc

# Host-specific items: anything that belongs only on the current host
HOST=$(hostname -s|tr "[:upper:]" "[:lower:]")
[ -f ~/.dotfiles.local/$HOST.bashrc ] && . ~/.dotfiles.local/$HOST.bashrc

# Now just anything left that's purely local
[ -f ~/.dotfiles.local/bashrc ] && . ~/.dotfiles.local/bashrc

[ -e ~/.dotfiles/bash_prompt ] && . ~/.dotfiles/bash_prompt

[ -f ~/.dotfiles/bash_aliases ] && . ~/.dotfiles/bash_aliases

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
