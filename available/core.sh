#!/bin/bash

# Core shell settings
set -o vi

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

shopt -s histappend
shopt -s checkwinsize

# OS-specific environment and settings
case "$(uname -s)" in
Darwin*)
    # macOS specific settings
    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
    export COPYFILE_DISABLE=true
    export QUOTING_STYLE=literal

    # Homebrew settings
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_EMOJI=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1

    # macOS specific aliases
    alias brew-up='${HOMEBREW_PREFIX}/bin/brew update && \
            (${HOMEBREW_PREFIX}/bin/brew upgrade; ${HOMEBREW_PREFIX}/bin/brew upgrade --cask)'
    alias brew86-up='${HOMEBREW86_PREFIX}/bin/brew86 update && \
            (${HOMEBREW86_PREFIX}/bin/brew86 upgrade; ${HOMEBREW86_PREFIX}/bin/brew86 upgrade --cask)'
    alias show-files='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
    alias hide-files='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
    alias fix-openwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
            -kill -r -domain local -domain system -domain user'
    alias cpu-model='sysctl -n machdep.cpu.brand_string'
    alias reset-launchpad='defaults -currentHost write com.apple.dock ResetLaunchPad -bool true; killall Dock'
    alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
    alias tm-wtf='sudo log stream --style syslog --predicate '\''processImagePath contains "backupd"'\'' --info'
    alias tm-logs='log stream --style syslog  --predicate '"'"'senderImagePath contains[cd] "TimeMachine"'"'"' --info'
    ;;
Linux*)
    # Linux specific settings
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi

    # Debian specific aliases
    if grep -qi "ID.*=debian" /etc/*release; then
        alias apt-up='sudo -E apt-get update; sudo -E apt-get upgrade'
    fi

    # Systemd functions
    startstat() {
        systemctl start ${*}
        systemctl status ${*}
    }

    # Raspberry Pi specific
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        alias set-rpi-time='sudo /usr/sbin/ntpdate -s; sudo /sbin/hwclock --adjust; sudo /sbin/hwclock --systohc'
        alias get-rpi-temp='awk '\''{print "Temp:",$1/1000,"C"}'\'' /sys/class/thermal/thermal_zone0/temp'
    fi
    ;;
esac

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

# shopt management
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
