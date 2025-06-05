#!/bin/zsh

# Load a host-specific config (if any) to establish locations of key binaries
HOST=$(hostname -s | sed 's/-.gbe$//g' | tr "[:upper:]" "[:lower:]")
[[ -r ${HOME}/.dotfiles.local/${HOST}-bootstrap ]] &&
    . ${HOME}/.dotfiles.local/${HOST}-bootstrap

export EDITOR=${HOMEBREW_PREFIX}/bin/vim

set -o vi

export GZIP=-9
export BZIP=-9

export CASE_SENSITIVE="true"
export QUOTING_STYLE=literal

eval $(/usr/libexec/path_helper -s)

# export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
# export HISTTIMEFORMAT="[%F %T] "
# export HIST_STAMPS="yyyy-mm-dd"

# Ref: https://zsh.sourceforge.io/Doc/Release/Options.html#Options
unsetopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
unsetopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

# Symlink additional configs here to have them sourced, numbering for order
# (fpath completions should get run here)
for CFG in ${HOME}/.dotfiles/enabled/??-*; do
    . ${CFG}
done

STARSHIP=${STARSHIP:-${HOMEBREW_PREFIX}/bin/starship}

# see: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# fpath=(${HOME}/.zsh/zsh-completions/src $fpath)

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
# autoload -Uz bashcompinit && bashcompinit

# (post compinit completions now can be run)
whence -w kubectl &>/dev/null &&
    source <(kubectl completion zsh)
whence -w kubelogin &>/dev/null &&
    source <(kubelogin completion zsh)

complete -o nospace -C /Users/scott/.asdf/shims/terraform terraform

source ${HOMEBREW_PREFIX}/etc/bash_completion.d/az

source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${HOME}/.zsh/zsh-hist/zsh-hist.plugin.zsh
source ${HOME}/.fzf.zsh

eval "$(${STARSHIP} init zsh)"
export STARSHIP_CONFIG=${HOME}/.config/starship/starship.toml

# Ref: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Accessing-On_002dLine-Help
unalias run-help
autoload run-help
