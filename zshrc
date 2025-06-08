#!/bin/zsh

# Load a host-specific config (if any) to establish locations of key binaries
HOST=$(hostname -s | sed 's/-.gbe$//g' | tr "[:upper:]" "[:lower:]")
[[ -r ${HOME}/.dotfiles.local/${HOST}-bootstrap ]] &&
    . ${HOME}/.dotfiles.local/${HOST}-bootstrap

# macOS: set up system paths
if [[ "$(uname)" == "Darwin" ]]; then
    eval $(/usr/libexec/path_helper -s)
else
    # TBD: Might need to set up /etc/profile.d or similar here later on *nixes
    :
fi

if command -v brew &>/dev/null; then
    eval "$(brew shellenv)"
fi

export EDITOR=${HOMEBREW_PREFIX}/bin/vim

set -o vi

export GZIP=-9

export CASE_SENSITIVE="true"
export QUOTING_STYLE=literal

# History configuration (works on both macOS and Linux)
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# Timestamps: zsh stores timestamps if EXTENDED_HISTORY is set (see below).
# To view timestamps, use: history -i

# Ref: https://zsh.sourceforge.io/Doc/Release/Options.html#Options
# History sharing: unsetopt SHARE_HISTORY means each session keeps its own history until exit.
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

# Completion system setup
# Only run compinit once; -C skips security checks (faster, but only if you trust your completions)
autoload -U +X compinit && compinit -C
autoload -U +X bashcompinit && bashcompinit # Needed for bash-style 'complete' below

# (post compinit completions now can be run)
whence -w kubectl &>/dev/null &&
    source <(kubectl completion zsh)
whence -w kubelogin &>/dev/null &&
    source <(kubelogin completion zsh)

complete -o nospace -C /Users/scott/.asdf/shims/terraform terraform

[[ -f ${HOMEBREW_PREFIX}/etc/bash_completion.d/az ]] && source ${HOMEBREW_PREFIX}/etc/bash_completion.d/az

# Guard plugin sources with file existence checks
[[ -f ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
    source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
    source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f ${HOME}/.zsh/zsh-hist/zsh-hist.plugin.zsh ]] && source ${HOME}/.zsh/zsh-hist/zsh-hist.plugin.zsh
[[ -f ${HOME}/.fzf.zsh ]] && source ${HOME}/.fzf.zsh

eval "$(${STARSHIP} init zsh)"
export STARSHIP_CONFIG=${HOME}/.config/starship/starship.toml

# Ref: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Accessing-On_002dLine-Help
unalias run-help
autoload run-help
