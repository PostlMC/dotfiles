#!/bin/bash

ln -s ../available/00-environment 00-environment 2>/dev/null
ln -s ../available/functions 10-functions 2>/dev/null
ln -s ../available/aliases 11-aliases 2>/dev/null
ln -s ../available/ssh-agent 12-ssh-agent 2>/dev/null
ln -s ../available/prompt-bash 19-prompt 2>/dev/null
ln -s ../available/python 20-python 2>/dev/null
ln -s ../available/kubernetes 30-kubernetes 2>/dev/null

OS=$(uname|awk -F "(_|/|-)" '{print tolower($1)}')
[ -f ../available/misc-${OS} ] && \
    ln -s ../available/misc-${OS} 90-misc-${OS} 2>/dev/null

SH=$(basename ${SHELL})
[ -f ../available/misc-${SH} ] && \
    ln -s ../available/misc-${SH} 91-misc-${SH} 2>/dev/null

HOST=$(hostname -s|tr "[:upper:]" "[:lower:]")
[ -f ~/.dotfiles.local/${HOST}-environment ] && \
    ln -s ~/.dotfiles.local/${HOST}-environment 01-environment 2>/dev/null
[ -f ~/.dotfiles.local/${HOST}-misc ] && \
    ln -s ~/.dotfiles.local/${HOST}-misc 99-misc 2>/dev/null
