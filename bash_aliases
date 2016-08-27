# For safety's sake
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


# Old habits
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'


# [Way too] Common typos
alias ls-la='ls -la'
alias ls-l='ls -l'
ls-() {
    ls -$@
}
alias ln-s='ln -s'
alias cd..='cd ..'
alias rm-f='rm -f'
alias rm-rf='rm -rf'


# Laziness enablement
alias ..='cd ..'
alias ...='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'


# ISO 8601 is your friend
## Local (server) time
alias now="date '+%Y-%m-%dT%H:%M:%S%z'"
alias nowc="date '+%Y%m%dT%H%M%S%Z'"

## UTC (zulu) time
alias zulu="date -u '+%Y-%m-%dT%H:%M:%S%z'"
alias zuluc="date -u '+%Y%m%dT%H%M%SZ'"


# Python
alias pipup='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -I {} sudo -H pip install -U {}'


# cURL
## curl-trace from https://github.com/wickett/dotfiles/blob/master/.curl-format
alias curl-trace='curl -so /dev/null -w "@${HOME}/.dotfiles/curl-format"'


# OpenSSL
alias sclient='echo | openssl s_client -showcerts -connect '
alias ssl2='openssl s_client -ssl2 -connect'
alias ssl3='openssl s_client -ssl3 -connect'
alias tls1_2='openssl s_client -tls1_2 -connect'
alias tls1_1='openssl s_client -tls1_1 -connect'
alias tls1='openssl s_client -tls1 -connect'
alias dtls1='openssl s_client -dtls1 -connect'

alias x509='openssl x509 -noout -text'

aesenc() {
    openssl aes-256-cbc -e -salt -in "$1" -out "$1.enc"
}

cert2key() {
    N=$( (openssl x509 -in $1 -noout -modulus | \
        openssl md5; openssl rsa -in $2 -noout -modulus | openssl md5) | uniq | wc -l )
    if [ $N == 1 ]
    then
        echo "Cert and key MATCH"
    else
        echo "Cert and key DO NOT MATCH"
    fi
}

get-chain() {
    echo | openssl s_client -connect ${1}:${2:-443} -showcerts 2>/dev/null | \
        awk '/-----BEGIN/{out=sprintf("'${1}'-%02d.cer",++count); p=1} /-----END/ {print > out; p=0} p {print > out}'
}

showp12cert() { openssl pkcs12 -in $1 -nokeys -clcerts | openssl x509 -noout -text; }

dumpp7certs() { openssl pkcs7 -in $1 -print_certs | \
    awk '/-----BEGIN/ {out=sprintf("'${1%.*}'-%02d.cer",++count); p=1} /-----END/ {print > out; p=0} p {print > out}'; }

dumpsitecerts() { echo | openssl s_client -connect ${1} -showcerts 2>/dev/null | \
    awk '/-----BEGIN/ {out=sprintf("'${1}'-%02d.cer",++count); p=1} /-----END/ {print > out; p=0} p {print > out}'; }


# SSH 
## Generate SSH aliases for shortnames in ~/.ssh/config
if [ -s $HOME/.ssh/config ]
then
    for HOST in $(awk '/^Host /&&$2!~/\*/{for(i=1;i<=NF;++i)if(i>1&&$i!~/\./)print $i}' $HOME/.ssh/config)
    do
        alias $HOST="ssh $HOST"
    done
fi


# Git
## TODO: deal with spaces in directory names
gitremotes() {
    for DIR in $(find . -type d)
    do
        [ -d "$DIR"/.git ] && (cd "$DIR"; pwd; git remote -v; echo)
    done
}

## Assumes jq is available!
ghostars() {
    for ORG in $*
    do
        printf "$ORG: %s\n" $(curl -s https://api.github.com/orgs/$ORG/repos | \
        jq '[ .[] | .stargazers_count ] | add')
    done
}


# docker
alias dpql='docker ps -ql'
alias dpsa='docker ps -a'
alias dimgsize='docker images 2>&1 | awk '\''{sum+=$(NF-1)}END{print sum,"MB"};'\'''


# tmux
alias tmux='tmux -2'
alias tmuxa='tmux -2 attach -t'


# Misc
## ls with numeric (octal) permissions at the start of each line
alias lso="ls -alG | \
    awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

alias badlinks='for i in $(find . -type l); do [ -e $i ] || echo $i; done'

## Assumes lynx is available!
alias html2ascii='lynx -force_html -stdin -dump -nolist'

#alias myip="curl -s http://checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
#alias myip='curl -s http://ifconfig.me/ip'
alias myip='curl -s http://www.gicsm.org/u/ip.php'

alias sortip='sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n'

## I do not know why I keep these around
alias apnic='whois -h whois.apnic.net'
alias ripe='whois -h whois.ripe.net'
alias arin='whois -h whois.arin.net'
alias afrinic='whois -h whois.afrinic.net'
alias lacnic='whois -h whois.lacnic.net'
alias org='whois -h whois.pir.org'
alias edu='whois -h whois.educause.edu'
alias cctld='whois -h whois.iana.org'
alias bgp='whois -h riswhois.ripe.net'
