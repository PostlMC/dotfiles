alias brewup='brew update && brew upgrade $(brew outdated)'

alias show-files='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hide-files='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

alias fix-openwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

alias cpumodel='sysctl -n machdep.cpu.brand_string'

alias reset-launchpad='defaults -currentHost write com.apple.dock ResetLaunchPad -bool true; killall Dock'

export COPYFILE_DISABLE=true

defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Animations to disable (for performance reasons) according to http://lifehacker.com/speed-up-an-old-mac-by-disabling-these-animations-1745282066
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
#defaults write -g QLPanelAnimationDuration -float 0
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.finder DisableAllAnimations -bool true

alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

shrink-qcow2 () {
    mv ${1} ${1}.BACKUP && qemu-img convert -O qcow2 ${1}.BACKUP ${1}
}

export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
#export HOMEBREW_BUILD_FROM_SOURCE=1
