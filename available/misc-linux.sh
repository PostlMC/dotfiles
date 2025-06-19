#!/bin/bash

# Linux-specific configurations and utilities

# Debian/Ubuntu package management shortcuts
if command -v apt-get >/dev/null 2>&1; then
    alias apt-up='sudo -E apt-get update && sudo -E apt-get upgrade'
fi

# Systemd service management shortcuts
if command -v systemctl >/dev/null 2>&1; then
    restartstat() {
        systemctl restart "${@}"
        systemctl status "${@}"
    }

    alias sc-status='systemctl status'
    alias sc-restart='systemctl restart'
    alias sc-stop='systemctl stop'
    alias sc-start='systemctl start'
    alias sc-enable='systemctl enable'
    alias sc-disable='systemctl disable'
fi

# Common Linux utilities
if command -v journalctl >/dev/null 2>&1; then
    alias logs='journalctl -f'
    alias logs-boot='journalctl -b'
fi
