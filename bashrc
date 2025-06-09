#!/bin/bash

# Load a host-specific config (if any) to establish locations of key binaries
HOST=$(hostname -s | sed 's/-.gbe$//g' | tr "[:upper:]" "[:lower:]")
[[ -r ${HOME}/.dotfiles.local/${HOST}-bootstrap ]] &&
    . ${HOME}/.dotfiles.local/${HOST}-bootstrap

# Set vi mode
set -o vi

# Environment variables
export GZIP=-9
export CASE_SENSITIVE="true"
export QUOTING_STYLE=literal

# History configuration
export HISTFILE=~/.bash_history
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:ls:[bf]g:exit"

# Helps with uv default python installed with: `uv python install 3.12 --default --preview`
[[ -d "${HOME}/.local/bin" ]] && PATH="${HOME}/.local/bin:$PATH"
[[ -d "${HOME}/bin" ]] && PATH="${HOME}/bin:$PATH"

# Source additional configs in .dotfiles/enabled, numbering for order
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    [[ -r "${CFG}" ]] && . "${CFG}"
done

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
elif [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
    . /opt/homebrew/etc/profile.d/bash_completion.sh
fi

if command -v kubectl &>/dev/null; then
    source <(kubectl completion bash)
fi
if command -v kubelogin &>/dev/null; then
    source <(kubelogin completion bash)
fi

complete -o nospace -C /Users/scott/.asdf/shims/terraform terraform
