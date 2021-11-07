#!/bin/zsh

set -o vi

unsetopt share_history

# export ZSH="${HOME}/.oh-my-zsh"
# export ZSH_THEME="dracula"
export HIST_STAMPS="yyyy-mm-dd"
export CASE_SENSITIVE="true"
export QUOTING_STYLE=literal

# Now, either do this:
# . ${ZSH}/oh-my-zsh.sh

# plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# zstyle ':completion:*' completer _complete _ignored
# zstyle :compinstall filename '/Users/scott/.zshrc'

# ...or do this:
autoload -Uz compinit
compinit

fpath=(${HOME}/.zsh/zsh-completions/src $fpath)
type kubectl &> /dev/null && source <(kubectl completion zsh)

source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml
# END: or

# Symlink additional configs here to have them sourced, numbering for order
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    . ${CFG}
done
