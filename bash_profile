#!/bin/bash

[[ -f ${HOME}/.dotfiles.local/00-environment ]] && \
    . ${HOME}/.dotfiles.local/00-environment

# Symlink additional configs here to have them sourced, numbering for order
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    . ${CFG}
done
