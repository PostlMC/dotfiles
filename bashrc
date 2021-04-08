#!/bin/bash

# If not running interactively, don't do anything
[ -z "${PS1}" ] && return

# Symlink additional configs here to have them sourced, numbering for order
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    . ${CFG}
done
source "$HOME/.cargo/env"
