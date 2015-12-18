alias brewup='brew update && brew upgrade $(brew outdated)'
alias caveats="brew info $(brew list) | awk '/^==> Caveats$/,/^[a-z][a-zA-Z0-9_+-]+: stable |^==> (Dependencies|Options)$/'"

alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

alias cpumodel='sysctl -n machdep.cpu.brand_string'

export COPYFILE_DISABLE=true

defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Animations to disable (for performance reasons) according to http://lifehacker.com/speed-up-an-old-mac-by-disabling-these-animations-1745282066
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
#defaults write -g QLPanelAnimationDuration -float 0
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.finder DisableAllAnimations -bool true
