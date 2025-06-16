#!/bin/bash

if command -v curl &>/dev/null; then
    # curl-trace from https://github.com/wickett/dotfiles/blob/master/.curl-format
    alias curl-trace='curl -so /dev/null -w "@${HOME}/.dotfiles/curl-format"'
    alias curl-status='curl -skw "%{http_code}" -o /dev/null'
    alias myip='curl -s http://ifconfig.me/ip'
fi

alias digs='dig +short'
alias sortip='sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n'

alias apnic='whois -h whois.apnic.net'
alias ripe='whois -h whois.ripe.net'
alias arin='whois -h whois.arin.net'
alias afrinic='whois -h whois.afrinic.net'
alias lacnic='whois -h whois.lacnic.net'
alias org='whois -h whois.pir.org'
alias edu='whois -h whois.educause.edu'
alias cctld='whois -h whois.iana.org'
alias bgp='whois -h riswhois.ripe.net'

# Handy backup funtions for moving things around
if command -v nc &>/dev/null; then
    send() {
        HOST=$1
        shift
        echo "Sending to $HOST:10301..."
        if command -v pv >/dev/null 2>&1; then
            tar czf - $@ | pv | nc -Nv $HOST 10301
        else
            echo 1>&2 "pv not found, so no stats for you!"
            tar cvzf - $@ | nc -Nv $HOST 10301
        fi
        echo "Done"
    }

    recv() {
        echo "$(hostname -f): Listening on port 10301..."
        nc -nlv 10301 | tar xvzp 2>/dev/null
        echo "Done"
    }
fi
