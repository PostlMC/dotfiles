#!/bin/zsh

HOST=$(hostname -s|tr "[:upper:]" "[:lower:]")
[ -f ~/.dotfiles.local/${HOST}-bootstrap ] && . ~/.dotfiles.local/${HOST}-bootstrap

export HISTSIZE=1000000
export SAVEHIST=1000000

# export HISTTIMEFORMAT="[%F %T] "
# export HIST_STAMPS="yyyy-mm-dd"

unsetopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
unsetopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

export CASE_SENSITIVE="true"
export QUOTING_STYLE=literal

# Now, either do this:
# export ZSH="${HOME}/.oh-my-zsh"
# export ZSH_THEME="dracula"

# . ${ZSH}/oh-my-zsh.sh

# plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# zstyle ':completion:*' completer _complete _ignored
# zstyle :compinstall filename '/Users/scott/.zshrc'

# ...or do this:
STARSHIP=${STARSHIP:-/usr/local/bin/starship}

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

# >>> Turns out it's important to set up PATH _before_ completions load
# Symlink additional configs here to have them sourced, numbering for order
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    . ${CFG}
done
# >>> END: PATH set up

fpath=(${HOME}/.zsh/zsh-completions/src $fpath)

source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

type kubectl &> /dev/null && source <(kubectl completion zsh)
source ${HOME}/opt/homebrew/etc/bash_completion.d/az

eval "$(${STARSHIP} init zsh)"
export STARSHIP_CONFIG=${HOME}/.config/starship.toml
# END: or
