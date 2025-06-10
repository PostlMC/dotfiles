#!/bin/bash

set -o vi

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

shopt -s histappend
shopt -s checkwinsize

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

## Not that I use most of these much (or, ever), but it's handy to be able to flip them easily if I do
shopt-alias() {
    for OPT in $(shopt | awk '{print $1}'); do
        # Don't stomp on any existing stuff
        if ! command -v $OPT >/dev/null 2>&1 && ! alias $OPT 2>/dev/null && ! declare -f $OPT; then
            alias $OPT="if shopt -q $OPT; then shopt -u $OPT && echo \"$OPT off\"; \
                else shopt -s $OPT && echo \"$OPT on\"; fi"
        fi
    done
}
shopt-alias
