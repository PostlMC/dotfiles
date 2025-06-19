#!/bin/bash

# Google Cloud SDK
command -v gcloud >/dev/null 2>&1 || return

alias gcloud-up='gcloud components update --quiet'

# Source completion and path files - handle different installation locations
if [[ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc ]]; then
    # macOS Homebrew Cask installation
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc

elif [[ -f /usr/share/google-cloud-sdk/completion.bash.inc ]]; then
    # Linux package manager installation
    source /usr/share/google-cloud-sdk/completion.bash.inc
    source /usr/share/google-cloud-sdk/path.bash.inc

elif [[ -f "${HOME}/google-cloud-sdk/completion.bash.inc" ]]; then
    # User installation
    source "${HOME}/google-cloud-sdk/completion.bash.inc"
    source "${HOME}/google-cloud-sdk/path.bash.inc"
fi
