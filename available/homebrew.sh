#!/bin/bash

command -v brew >/dev/null 2>&1 || return

# Optimize Homebrew behavior for faster, cleaner operation
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

alias brew-up='${HOMEBREW_PREFIX}/bin/brew update && \
        (${HOMEBREW_PREFIX}/bin/brew upgrade; ${HOMEBREW_PREFIX}/bin/brew upgrade --cask)'
alias brew86-up='${HOMEBREW86_PREFIX}/bin/brew86 update && \
        (${HOMEBREW86_PREFIX}/bin/brew86 upgrade; ${HOMEBREW86_PREFIX}/bin/brew86 upgrade --cask)'

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
