# Environment

# Apple needs to stop moving this ball (not even sure if these work anymore)
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true

# Fix ls 8.25's wonderful gift from brew/coreutils
export QUOTING_STYLE=literal

# Great, now even homebrew misbehaves
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
#export HOMEBREW_BUILD_FROM_SOURCE=1


# General Mac settings

# Keep the .DS_Store files to yourself, Mac
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Animations to disable (for performance reasons, and because reasons) according to
# http://lifehacker.com/speed-up-an-old-mac-by-disabling-these-animations-1745282066
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
#defaults write -g QLPanelAnimationDuration -float 0
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.finder DisableAllAnimations -bool true


# Aliases/Functions

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
