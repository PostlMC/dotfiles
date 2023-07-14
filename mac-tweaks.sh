#!/bin/bash

# General Mac settings

# Keep the .DS_Store files to yourself, Mac
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Stop warning me about changing extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Animations to disable (for performance reasons, and because reasons) according to
# http://lifehacker.com/speed-up-an-old-mac-by-disabling-these-animations-1745282066
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

#defaults write -g QLPanelAnimationDuration -float 0

defaults write com.apple.dock launchanim -bool false
defaults write com.apple.finder DisableAllAnimations -bool true

# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1.5

# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Disable swipe to navigate behavior in browsers
# Find the bundle identifier for the browser in question with:
# osascript -e 'id of app "'$appName'"'
# ..where $appName is the name of the browser

# Safari
defaults write com.apple.Safari AppleEnableSwipeNavigateWithScrolls -bool FALSE
# Edge
defaults write com.microsoft.edgemac AppleEnableSwipeNavigateWithScrolls -bool FALSE
# Chrome
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
# FireFox
defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool FALSE
# Brave
defaults write com.brave.Browser AppleEnableSwipeNavigateWithScrolls -bool FALSE
