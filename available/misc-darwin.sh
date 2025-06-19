#!/bin/bash

# macOS-specific configurations and utilities

# Prevent resource fork and extended attribute issues when copying files
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true
export QUOTING_STYLE=literal

# Mac OS-specific aliases
alias show-files='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hide-files='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias fix-openwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
        -kill -r -domain local -domain system -domain user'
alias cpu-model='sysctl -n machdep.cpu.brand_string'
alias reset-launchpad='defaults -currentHost write com.apple.dock ResetLaunchPad -bool true; killall Dock'
alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias tm-wtf='sudo log stream --style syslog --predicate '\''processImagePath contains "backupd"'\'' --info'
alias tm-logs='log stream --style syslog  --predicate '"'"'senderImagePath contains[cd] "TimeMachine"'"'"' --info'
