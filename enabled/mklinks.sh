#!/bin/bash

HOST=$(hostname -s | tr "[:upper:]" "[:lower:]")
OS=$(uname | awk -F "(_|/|-)" '{print tolower($1)}')

# Core environment and bootstrap (must load first)
[ -f ~/.dotfiles.local/${HOST}-bootstrap ] &&
    ln -s ~/.dotfiles.local/${HOST}-bootstrap 01-bootstrap 2>/dev/null

# Core shell configuration (loaded early as other files may depend on it)
ln -s ../available/core.sh 02-core 2>/dev/null

# TODO: split out OS core items and link as 03-core-os

# Tools we should have everywhere
command -v openssl >/dev/null 2>&1 && ln -s ../available/openssl.sh 10-openssl 2>/dev/null
command -v ssh >/dev/null 2>&1 && ln -s ../available/ssh.sh 11-ssh 2>/dev/null

# Load Homebrew on both macOS and Linux (for Aurora)
command -v brew >/dev/null 2>&1 && ln -s ../available/homebrew.sh 20-homebrew 2>/dev/null

# OS-specific configurations (load after core, network, and tools)
case "$OS" in
darwin)
    ln -s ../available/misc-darwin.sh 21-misc-darwin 2>/dev/null
    ;;
linux)
    # Check for package managers and create appropriate links
    if command -v apt-get >/dev/null 2>&1 || command -v yum >/dev/null 2>&1; then
        ln -s ../available/misc-linux.sh 22-misc-linux 2>/dev/null
    fi

    # Raspberry Pi detection using device tree model
    if [ -f /proc/device-tree/model ] && grep -q "Raspberry Pi" /proc/device-tree/model; then
        ln -s ../available/misc-rpi.sh 23-misc-rpi 2>/dev/null
    fi
    ;;
esac

# Now we can load general development tools
command -v git >/dev/null 2>&1 && ln -s ../available/git.sh 30-git 2>/dev/null
command -v docker >/dev/null 2>&1 && ln -s ../available/docker.sh 31-docker 2>/dev/null

# Language-specific tools (load after general development tools)
command -v python >/dev/null 2>&1 && ln -s ../available/python.sh 40-python 2>/dev/null
command -v go >/dev/null 2>&1 && ln -s ../available/golang.sh 41-golang 2>/dev/null
command -v rustc >/dev/null 2>&1 && ln -s ../available/rust.sh 42-rust 2>/dev/null

# Cloud and platform tools (load after all the other stuff)
command -v az >/dev/null 2>&1 && ln -s ../available/azure.sh 60-azure 2>/dev/null
command -v gcloud >/dev/null 2>&1 && ln -s ../available/gcloud.sh 61-gcloud 2>/dev/null
command -v kubectl >/dev/null 2>&1 && ln -s ../available/kubernetes.sh 70-kubernetes 2>/dev/null
command -v terraform >/dev/null 2>&1 && ln -s ../available/terraform.sh 71-terraform 2>/dev/null

# Miscellaneous host-specific items (load last to allow overrides)
[ -f ~/.dotfiles.local/${HOST}-misc ] &&
    ln -s ~/.dotfiles.local/${HOST}-misc 99-misc 2>/dev/null
