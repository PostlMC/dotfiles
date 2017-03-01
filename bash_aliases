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
# Local (server) time
alias now="date '+%Y-%m-%dT%H:%M:%S%z'"
alias nowc="date '+%Y%m%dT%H%M%S%Z'"
# UTC (zulu) time
alias zulu="date -u '+%Y-%m-%dT%H:%M:%S%z'"
alias zuluc="date -u '+%Y%m%dT%H%M%SZ'"


# cURL
# curl-trace from https://github.com/wickett/dotfiles/blob/master/.curl-format
alias curl-trace='curl -so /dev/null -w "@${HOME}/.dotfiles/curl-format"'


# OpenSSL
alias sclient='echo | openssl s_client -showcerts -connect '
alias ssl2='openssl s_client -ssl2 -connect'
alias ssl3='openssl s_client -ssl3 -connect'
alias tls1_2='openssl s_client -tls1_2 -connect'
alias tls1_1='openssl s_client -tls1_1 -connect'
alias tls1='openssl s_client -tls1 -connect'
alias dtls1='openssl s_client -dtls1 -connect'
alias x509='openssl x509 -noout -text -in'


# Git
alias gitv='GIT_SSH_COMMAND="ssh -v" GIT_CURL_VERBOSE=1 GIT_TRACE=1 git'


# Docker
alias dpql='docker ps -ql'
alias dpsa='docker ps -a'
alias dimgsize='docker images 2>&1 | awk '\''{sum+=$(NF-1)}END{print sum,"MB"};'\'''

alias lookl33t='docker run -t --rm --name hollywood --net none jess/hollywood; docker rm -f hollywood; clear'


# Potentially dangerous!
alias docker-clean='docker rm $(docker ps -q -f 'status=exited') 2>/dev/null \
    docker rmi $(docker images -q -f "dangling=true") 2>/dev/null \
    docker volume rm $(docker volume ls -q -f 'dangling=true')  2>/dev/null'


# tmux
alias tmux='tmux -2'
alias tmuxa='tmux -2 attach -t'


# Misc
# ls with numeric (octal) permissions at the start of each line
alias lso="ls -alG | \
    awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

#alias find-by-mod='find . -type f -printf "%T+ %p\n" -exec sh -c "openssl md5 {} | \
#    awk '{printf \$NF\" \" }'" \; | sort -k2.2 -V'

alias badlinks='for i in $(find . -type l); do [ -e $i ] || echo $i; done'

alias digs='dig +short'

# Assumes lynx is available!
alias html2ascii='lynx -force_html -stdin -dump -nolist'
#alias myip="curl -s http://checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
#alias myip='curl -s http://ifconfig.me/ip'
alias myip='curl -s http://www.gicsm.org/u/ip.php'

alias sortip='sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n'


# I do not know why I keep these around
alias apnic='whois -h whois.apnic.net'
alias ripe='whois -h whois.ripe.net'
alias arin='whois -h whois.arin.net'
alias afrinic='whois -h whois.afrinic.net'
alias lacnic='whois -h whois.lacnic.net'
alias org='whois -h whois.pir.org'
alias edu='whois -h whois.educause.edu'
alias cctld='whois -h whois.iana.org'
alias bgp='whois -h riswhois.ripe.net'
