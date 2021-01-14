#!/bin/zsh

export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="dracula"
export HIST_STAMPS="yyyy-mm-dd"
export CASE_SENSITIVE="true"
export QUOTING_STYLE=literal

# Not that I use [m]any plugins
# export ZPLUG_HOME=/usr/local/opt/zplug
# . $ZPLUG_HOME/init.zsh
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# plugins=(git)1

. ${ZSH}/oh-my-zsh.sh

# Symlink additional configs here to have them sourced, numbering for order
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    . ${CFG}
done
