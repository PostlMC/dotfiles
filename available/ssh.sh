#!/bin/bash

command -v ssh >/dev/null 2>&1 || return

# SSH aliases
## Useful for occasional debugging without changing configs
alias sshpw='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# SSH functions
## Generate SSH aliases for shortnames in ~/.ssh/config (as a function so I can reload quickly)
ssh-alias() {
    if [ -s ${HOME}/.ssh/config ]; then
        INCS=($(awk '/^Include/{print $NF}' ${HOME}/.ssh/config))
        for FILE in config ${INCS[@]}; do
            for NAME in $(awk '/^Host / && $2 !~ /\*/ {for (i=1;i<=NF;++i) if (i>1 && $i !~ /\./ ) print $i}' \
                ${HOME}/.ssh/${FILE}); do
                alias ${NAME}="ssh ${NAME}"
            done
        done
    fi
}
ssh-alias

## For hosts where I immediately sudo su -
root() { ssh $@ -t "sudo su -"; }
