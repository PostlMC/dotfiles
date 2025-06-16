#!/bin/bash

# Core environment and bootstrap (must load first)
ln -s ../available/00-environment 00-environment 2>/dev/null

# Core shell configuration (loads early as other files may depend on it)
ln -s ../available/core.sh 01-core 2>/dev/null

# Network and security (load early as they may be needed by other tools)
ln -s ../available/network.sh 02-network 2>/dev/null
ln -s ../available/openssl.sh 03-openssl 2>/dev/null
ln -s ../available/ssh.sh 04-ssh 2>/dev/null
ln -s ../available/ssh-agent.sh 05-ssh-agent 2>/dev/null

# Development tools (load after core and network)
ln -s ../available/git.sh 10-git 2>/dev/null
ln -s ../available/docker.sh 11-docker 2>/dev/null

# Filesystem and datetime utilities (load after core)
ln -s ../available/filesystem.sh 20-filesystem 2>/dev/null
ln -s ../available/datetime.sh 21-datetime 2>/dev/null

# OS-specific configurations (load after core)
OS=$(uname | awk -F "(_|/|-)" '{print tolower($1)}')
case "$OS" in
darwin)
    ln -s ../available/homebrew.sh 30-homebrew 2>/dev/null
    ln -s ../available/misc-darwin.sh 31-misc-darwin 2>/dev/null
    ;;
linux)
    ln -s ../available/misc-linux.sh 30-misc-linux 2>/dev/null
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        ln -s ../available/misc-rpi.sh 31-misc-rpi 2>/dev/null
    fi
    ;;
esac

# Shell-specific configurations (load after core)
SH=$(basename ${SHELL})
[ -f ../available/prompt-${SH}.sh ] &&
    ln -s ../available/prompt-${SH}.sh 40-prompt 2>/dev/null

# Cloud and platform tools (load after core and network)
[ -f ../available/azure.sh ] && ln -s ../available/azure.sh 50-azure 2>/dev/null
[ -f ../available/gcloud.sh ] && ln -s ../available/gcloud.sh 51-gcloud 2>/dev/null
[ -f ../available/kubernetes.sh ] && ln -s ../available/kubernetes.sh 52-kubernetes 2>/dev/null
[ -f ../available/terraform.sh ] && ln -s ../available/terraform.sh 53-terraform 2>/dev/null

# Language-specific tools (load after core)
[ -f ../available/golang.sh ] && ln -s ../available/golang.sh 60-golang 2>/dev/null
[ -f ../available/python.sh ] && ln -s ../available/python.sh 61-python 2>/dev/null
[ -f ../available/rust.sh ] && ln -s ../available/rust.sh 62-rust 2>/dev/null

# Host-specific configurations (load last to allow overrides)
HOST=$(hostname -s | tr "[:upper:]" "[:lower:]")
[ -f ~/.dotfiles.local/${HOST}-environment ] &&
    ln -s ~/.dotfiles.local/${HOST}-environment 90-environment 2>/dev/null
[ -f ~/.dotfiles.local/${HOST}-misc ] &&
    ln -s ~/.dotfiles.local/${HOST}-misc 99-misc 2>/dev/null
