#!/bin/bash

# NoOP

# Completion system setup (bash)
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
elif [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
    . /opt/homebrew/etc/profile.d/bash_completion.sh
fi

# kubectl and kubelogin completions (if available)
if command -v kubectl &>/dev/null; then
    source <(kubectl completion bash)
fi
if command -v kubelogin &>/dev/null; then
    source <(kubelogin completion bash)
fi

# Terraform completion
complete -o nospace -C /Users/scott/.asdf/shims/terraform terraform

# (zsh-autosuggestions, zsh-syntax-highlighting, zsh-hist, fzf.zsh are zsh-specific)
