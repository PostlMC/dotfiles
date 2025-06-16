#!/bin/bash

# Color settings for ls and grep
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# For safety's sake
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Common ls variations
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

# [Way too] Common typos
alias ls-la='ls -la'
alias ls-l='ls -l'
alias ln-s='ln -s'
alias cd..='cd ..'
alias rm-f='rm -f'
alias rm-rf='rm -rf'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

# ls with numeric (octal) permissions at the start of each line
alias lso="ls -alG | \
    awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

# Find broken symlinks
alias badlinks='for i in $(find . -type l); do [ -e $i ] || echo $i; done'

# Function wrappers for common commands
ls-() {
    ls -$@
}

rm-() {
    rm -$@
}
# Random string generation functions
randh() {
    LC_ALL=C tr -dc 'a-f0-9' </dev/urandom | head -c${1:-16}
}

randa() {
    LC_ALL=C tr -dc '[:alnum:]' </dev/urandom | head -c${1:-16}
}

randg() {
    LC_ALL=C tr -dc '[:graph:]' </dev/urandom | head -c${1:-16}
}

# HTML to ASCII conversion (requires lynx)
if command -v lynx &>/dev/null; then
    alias html2ascii='lynx -force_html -stdin -dump -nolist'
fi

if command -v tmux &>/dev/null; then
    alias tmux='tmux -2'
    alias tmuxa='tmux -2 attach -t'
fi
