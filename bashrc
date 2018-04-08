#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

set -o vi

# CPU cycles are cheap these days
export GZIP=-9
export BZIP=-9

[ -d "${HOME}/bin" ] && PATH=${HOME}/bin:${PATH}

# OS-specific items: anything that belongs only on the current OS
OS=$(uname|awk -F "(_|/|-)" '{print $1}'|tr "[:upper:]" "[:lower:]")
[ -f ~/.dotfiles/$OS.bashrc ] && . ~/.dotfiles/$OS.bashrc

# Distro-specific items (so I can have Pi-specific config)
DISTRO=$([ -x /usr/bin/lsb_release ] && (/usr/bin/lsb_release -si | tr "[:upper:]" "[:lower:]"))
[ -f ~/.dotfiles/$DISTRO.bashrc ] && . ~/.dotfiles/$DISTRO.bashrc

# Host-specific items: anything that belongs only on the current host
HOST=$(hostname -s|tr "[:upper:]" "[:lower:]")
[ -f ~/.dotfiles.local/$HOST.bashrc ] && . ~/.dotfiles.local/$HOST.bashrc

# Now just anything left that's purely local
[ -f ~/.dotfiles.local/bashrc ] && . ~/.dotfiles.local/bashrc

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

shopt -s histappend
shopt -s checkwinsize

if [ -x $(which dircolors) ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

[ -f ~/.dotfiles/bash_aliases ] && . ~/.dotfiles/bash_aliases
[ -f ~/.dotfiles/bash_functions ] && . ~/.dotfiles/bash_functions

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[ -f ~/.dotfiles/bash_prompt ] && . ~/.dotfiles/bash_prompt
