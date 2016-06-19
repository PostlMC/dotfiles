# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Create a nifty reverse-truncated path for the prompt
function abbrev {
    local pwd_length=40
    if [ $(echo -n ${PWD} | wc -c | tr -d " ") -gt ${pwd_length} ]
    then
       NEWPWD="...$(echo -n ${PWD} | sed -e "s/.*\(.\{${pwd_length}\}\)/\1/")"
    else
       NEWPWD="$(echo -n ${PWD})"
    fi
}
PROMPT_COMMAND=abbrev

# Yes, ssh-copy-id will work, but may not always be there (OS/X)
function push-ssh-key {
  ssh "echo '`cat ~/.ssh/id_rsa.pub`' >> ~/.ssh/authorized_keys"
}

set -o vi

# Set up my common PATH directories
[ -d "${HOME}/bin" ] && PATH=${HOME}/bin:${PATH}
[ -d "${HOME}/.hosts" ] && PATH=${HOME}/.hosts:${PATH}

# Do some OS-specific junk
OS=$(uname|awk -F "(_|/|-)" '{print $1}'|tr "[:upper:]" "[:lower:]")
case "${OS}" in

    darwin)
        # OS X needs Homebrew dirs in the path
        PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:${PATH}
        ;;

    cygwin)
        # Set Solarized Dark(-ish) colors for terminals
        echo -ne '\e]4;1;#dc322f\a'  # red
        echo -ne '\e]4;2;#859900\a'  # green
        echo -ne '\e]4;3;#b58900\a'  # yellow
        echo -ne '\e]4;4;#268bd2\a'  # blue
        echo -ne '\e]4;5;#d33682\a'  # magenta
        echo -ne '\e]4;6;#2aa198\a'  # cyan
        echo -ne '\e]4;7;#eee8d5\a'  # white (light grey really) -> base2
        echo -ne '\e]4;8;#002b36\a'  # bold black (i.e. dark grey -> base03)
        echo -ne '\e]4;9;#cb4b16\a'  # bold red -> orange
        echo -ne '\e]4;10;#586e75\a'  # bold green -> base01
        echo -ne '\e]4;11;#657b83\a'  # bold yellow -> base00
        echo -ne '\e]4;12;#839496\a'  # bold blue -> base0
        echo -ne '\e]4;13;#6c71c4\a'  # bold magenta -> violet
        echo -ne '\e]4;14;#93a1a1\a'  # bold cyan -> base1
        echo -ne '\e]4;15;#fdfde3\a'  # bold white -> base3
        echo -ne '\e]10;#657b83\a'  # foreground -> base00
        echo -ne '\e]11;#002b36\a'  # background -> base03
        echo -ne '\e]12;#93a1a1\a'  # cursor -> base1
        ;;
esac

export PATH

export R_HISTFILE=~/.Rhistory

HISTCONTROL=ignoreboth
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case "$TERM" in
    linux) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

#if [ -x /usr/bin/tput ] && tput setaf 1 &>/dev/null; then
#    color_prompt=yes
#else
#    color_prompt=
#fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[0;32m\]\u@\h:\[\033[0;33m\]${NEWPWD}>\[\033[0m\] '
else
    PS1='\u@\h:${NEWPWD}> '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x $(which dircolors) ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

[[ -e ~/.dotfiles/bash_prompt ]] && . ~/.dotfiles/bash_prompt

[[ -f ~/.dotfiles/bash_aliases ]] && . ~/.dotfiles/bash_aliases

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# OS-specific items: anything else that belongs only on the current OS
[[ -f ~/.dotfiles/${OS}.bashrc ]] && . ~/.dotfiles/${OS}.bashrc

# Host-specific items: anything else that belongs only on the current host
HOST=$(hostname -s|tr "[:upper:]" "[:lower:]")
[[ -f ~/.dotfiles.local/${HOST}.bashrc ]] && . ~/.dotfiles.local/${HOST}.bashrc
