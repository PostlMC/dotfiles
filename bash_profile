#!/bin/bash

[[ -f ${HOME}/.dotfiles.local/00-environment ]] &&
    . ${HOME}/.dotfiles.local/00-environment

# Load a host-specific config (if any) to establish locations of key binaries
HOST=$(hostname -s | sed 's/-\.gbe$//g' | tr "[:upper:]" "[:lower:]")
[[ -r ${HOME}/.dotfiles.local/${HOST}-bootstrap ]] &&
    . ${HOME}/.dotfiles.local/${HOST}-bootstrap

# macOS: set up system paths
if [[ "$(uname)" == "Darwin" ]]; then
    eval $(/usr/libexec/path_helper -s)
else
    # TBD: Might need to set up /etc/profile.d or similar here later on *nixes
    :
fi

if command -v brew &>/dev/null; then
    eval "$(brew shellenv)"
fi

export EDITOR=${HOMEBREW_PREFIX}/bin/vim

set -o vi

export GZIP=-9

export CASE_SENSITIVE="true"
export QUOTING_STYLE=literal

# History configuration (works on both macOS and Linux)
export HISTFILE=~/.bash_history
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# Symlink additional configs here to have them sourced, numbering for order
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    . ${CFG}
done

# Starship prompt (if available)
STARSHIP=${STARSHIP:-${HOMEBREW_PREFIX}/bin/starship}
if [ -x "$STARSHIP" ]; then
    eval "$($STARSHIP init bash)"
    export STARSHIP_CONFIG=${HOME}/.config/starship/starship.toml
fi

# Bash completion for az CLI (if available)
[[ -f ${HOMEBREW_PREFIX}/etc/bash_completion.d/az ]] && source ${HOMEBREW_PREFIX}/etc/bash_completion.d/az

# Plugin sources (bash equivalents, if any)
# (zsh-autosuggestions, zsh-syntax-highlighting, zsh-hist, fzf.zsh are zsh-specific)
