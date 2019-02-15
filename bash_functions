#!/bin/bash

# Helpers

## Dug up on https://unix.stackexchange.com/questions/4965/keep-duplicates-out-of-path-on-source, where they were orginally
## credited to fink; used to provide PATH modification idempotence needed to fix VSCode's insistance on using login shells...
append_path() {
    if ! eval test -z "\"\${$1##*:$2:*}\"" -o -z "\"\${$1%%*:$2}\"" -o -z "\"\${$1##$2:*}\"" -o -z "\"\${$1##$2}\"" ; then
        eval "$1=\$$1:$2"
    fi
}

prepend_path() {
    if ! eval test -z "\"\${$1##*:$2:*}\"" -o -z "\"\${$1%%*:$2}\"" -o -z "\"\${$1##$2:*}\"" -o -z "\"\${$1##$2}\"" ; then
        eval "$1=$2:\$$1"
    fi
}


# OpenSSL
get-chain() {
    echo | openssl s_client -connect ${1}:${2:-443} -showcerts 2>/dev/null | \
        awk '/-----BEGIN/{out=sprintf("'${1}'-%02d.cer",++count); p=1} /-----END/ {print > out; p=0} p {print > out}'
}

cert2key() {
    N=$( (openssl x509 -in $1 -noout -modulus | \
        openssl md5; openssl rsa -in $2 -noout -modulus | openssl md5) | uniq | wc -l )
    if [ $N == 1 ]; then
        echo "Cert and key MATCH"
    else
        echo "Cert and key DO NOT MATCH"
    fi
}

show-p12cert() { openssl pkcs12 -in $1 -nokeys -clcerts | openssl x509 -noout -text; }

dump-p7certs() { openssl pkcs7 -in $1 -print_certs | \
    awk '/-----BEGIN/ {out=sprintf("'${1%.*}'-%02d.cer",++count); p=1} /-----END/ {print > out; p=0} p {print > out}'; }

fix-cert-name() {
    openssl x509 -in "${1}" -noout -subject | \
        awk -F= '{print $NF}' | \
        sed '
            s/.*/\L&/        # conver to lowercase (requires GNU sed!)
            s/ - */-/g       # condense hyphenations
            s/^\*/WILDCARD/  # label wildcards (I may hate this)
            s/[)]$//         # drop trailing parens
            s/ [(]/_/g       # condense/replace leading parens
            s/[ :/()*]/_/g   # replace misc chars with underscore
        '
}

aesenc() {
    openssl aes-256-cbc -e -salt -in "$1" -out "$1.enc"
}


# SSH
# Generate SSH aliases for shortnames in ~/.ssh/config (as a function so I can reload quickly)
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


# For hosts where I immediately sudo su -
root() { ssh $@ -t "sudo su -"; }


# Docker
docker-flatten() {
    docker export $(docker run -d ${1} /bin/bash) | docker import – ${2}
}

## Found at: http://stackoverflow.com/questions/24481564/how-can-i-find-docker-image-with-specific-tag-in-docker-registry-in-docker-comma
docker-tags() {
    curl -s -S "https://registry.hub.docker.com/v2/repositories/$@/tags/" | jq '."results"[]["name"]' | sort
}


# Kubernetes
kctla() { kubectl $* --all-namespaces; }


# Git
## TODO: deal with spaces in directory names
git-remotes() {
    for DIR in $(find . -type d); do
        [ -d "$DIR"/.git ] && \
            (cd "$DIR" && printf "${DIR}: [%s] %s\n" $(git remote -v | awk '{print $1" "$2}' | uniq))
    done
}

## Assumes jq is available!
ghostars() {
    for ORG in $@; do
        printf "$ORG: %s\n" $(curl -s https://api.github.com/orgs/$ORG/repos | \
        jq '[ .[] | .stargazers_count ] | add')
    done
}


# Misc
ls-() {
    ls -$@
}

## Send/receive files over netcat (port hardcoded for simplicity)
function send() {
    HOST=$1; shift
    echo "Sending to $HOST:10301..."
    if [ $(which pv) ]; then
        GZIP="-9" tar czf - $@ | pv | nc -v $HOST 10301
    else
        echo "pv not found, so no stats for you!"
        GZIP="-9" tar cvzf - $@ | nc -v $HOST 10301
    fi
    echo "Done"
}

function recv() {
    echo "$(hostname -f): Listening on port 10301..."
    nc $@ -lv 10301 | tar xvzp 2>/dev/null
    echo "Done"
}

## Not that I use most of these much (or, ever), but it's handy to be able to flip them easily if I do
function shopt-alias() {
    for OPT in $(shopt|awk '{print $1}'); do
        # Don't stomp on any existing stuff
        if ! which $OPT && ! alias $OPT 2>/dev/null && ! declare -f $OPT; then
            alias $OPT="if shopt -q $OPT; then shopt -u $OPT && echo \"$OPT off\"; \
                else shopt -s $OPT && echo \"$OPT on\"; fi"
        fi
    done
}
shopt-alias
