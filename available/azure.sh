#!/bin/bash

command -v az >/dev/null 2>&1 || return

# Forgot why I needed this, or why I gave it this name, but I'll keep it around as an
# example of using map with jq
az-abn() {
    if ! command -v jq &>/dev/null; then
        echo "Error: jq is required for az-abn function"
        return 1
    fi
    az account list | jq -r --arg name "$1" 'map(select(.name | test($name; "i"))) | .[].id'
}

# Source completion if available
if [[ -n "$HOMEBREW_PREFIX" ]] && [[ -f ${HOMEBREW_PREFIX}/etc/bash_completion.d/az ]]; then
    source ${HOMEBREW_PREFIX}/etc/bash_completion.d/az
elif [[ -f /usr/local/etc/bash_completion.d/az ]]; then
    source /usr/local/etc/bash_completion.d/az
fi
