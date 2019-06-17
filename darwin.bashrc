#!/bin/bash

# Environment
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Apple needs to stop moving this ball (not even sure if these work anymore)
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true

# Fix ls 8.25's wonderful gift from brew/coreutils
export QUOTING_STYLE=literal

# export HOMEBREW_VERBOSE=1
# export HOMEBREW_CURL_VERBOSE=1
# Great, now even homebrew misbehaves
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_COLOR=1
export HOMEBREW_NO_EMOJI=1
# export HOMEBREW_BUILD_FROM_SOURCE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1


# General Mac settings

# Keep the .DS_Store files to yourself, Mac
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Stop warning me about changing extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Animations to disable (for performance reasons, and because reasons) according to
# http://lifehacker.com/speed-up-an-old-mac-by-disabling-these-animations-1745282066
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
#defaults write -g QLPanelAnimationDuration -float 0
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.finder DisableAllAnimations -bool true

# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1.5

# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Disable Chrome's broken swipe behavior
defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE


# Aliases
alias brew-up='brew update && brew upgrade $(brew outdated)'

alias show-files='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hide-files='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

alias fix-openwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
    -kill -r -domain local -domain system -domain user'

alias cpu-model='sysctl -n machdep.cpu.brand_string'

alias reset-launchpad='defaults -currentHost write com.apple.dock ResetLaunchPad -bool true; killall Dock'

alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

shrink-qcow2 () {
    mv ${1} ${1}.BACKUP && qemu-img convert -O qcow2 ${1}.BACKUP ${1}
}

alias marked="open -a /Applications/Marked\\ 2.app"

alias pip-up='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -I {} pip install -U {}'
alias pip3-up='pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -I {} pip3 install -U {}'

alias tm-logs='log stream --style syslog  --predicate '"'"'senderImagePath contains[cd] "TimeMachine"'"'"' --info'

[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion
