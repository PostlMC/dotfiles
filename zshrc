#!/bin/zsh

# I always want this, and just didn't know where else to put it
set -o vi

# Load a host-specific config (if any) to establish locations of a few key binaries
HOST=$(hostname -s | sed 's/-.gbe$//g' | tr "[:upper:]" "[:lower:]")
[[ -r ${HOME}/.dotfiles.local/${HOST}-bootstrap ]] &&
    . ${HOME}/.dotfiles.local/${HOST}-bootstrap

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

# Symlink additional configs here to have them sourced, numbering for order
# (fpath completions should get run here)
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    . ${CFG}
done

# Now, for the pretty stuff, either do this:
# export ZSH="${HOME}/.oh-my-zsh"
# export ZSH_THEME="dracula"

# . ${ZSH}/oh-my-zsh.sh

# export ZSH="${HOME}/.oh-my-zsh"
# export ZSH_THEME="dracula"

# plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# zstyle ':completion:*' completer _complete _ignored
# zstyle :compinstall filename '/Users/scott/.zshrc'

# ...or do this:
STARSHIP=${STARSHIP:-/usr/local/bin/starship}

# see: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# fpath=(${HOME}/.zsh/zsh-completions/src $fpath)

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
# autoload -Uz bashcompinit && bashcompinit

# (post compinit completions now can be run)
whence -w kubectl &>/dev/null &&
    source <(kubectl completion zsh)

complete -o nospace -C /Users/scott/.asdf/shims/terraform terraform

# source ${HOMEBREW_PREFIX}/etc/bash_completion.d/az

source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${HOME}/.zsh/zsh-hist/zsh-hist.plugin.zsh
source "${HOME}/.config/asdf-direnv/zshrc"

eval "$(${STARSHIP} init zsh)"
export STARSHIP_CONFIG=${HOME}/.config/starship/starship.toml
# END: or

# Ref: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Accessing-On_002dLine-Help
unalias run-help
autoload run-help
