# General navigation aliai
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

## Common typos
alias ls-la='ls -la'
alias ls-l='ls -l'

## Adds numeric (octal) permissions at the start of each line
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

alias ln-s='ln -s'
alias badlinks='for i in $(find . -type l); do [ -e $i ] || echo $i is broken; done'

# For safety's sake (debatable)
alias rm-f='rm -f'
alias rm-rf='rm -rf'

# ISO 8601 is your friend
alias now="date '+%Y-%m-%dT%H:%M:%S%z'"
alias nowc="date '+%Y%m%dT%H%M%S%Z'"

alias zulu="date -u '+%Y-%m-%dT%H:%M:%S%z'"
alias zuluc="date -u '+%Y%m%dT%H%M%SZ'"

## 
alias tmux='tmux -2'
alias tmuxa='tmux -2 attach -t'

## Work in progress
#alias tailall='find /var/log | xargs file | grep text | cut -f 1 -d : | xargs tail -F'

alias html2ascii='lynx -force_html -stdin -dump -nolist'

alias g++='g++ -std=c++0x'

alias myip="curl -s http://checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
#alias myip='curl -s http://ifconfig.me/ip'

alias sclient='echo | openssl s_client -showcerts -connect '

alias sortip='sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n'

alias pipup='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -I {} sudo -H pip install -U {} --allow-external {} --allow-unverified {}'

alias apnic='whois -h whois.apnic.net'
alias ripe='whois -h whois.ripe.net'
alias arin='whois -h whois.arin.net'
alias afrinic='whois -h whois.afrinic.net'
alias lacnic='whois -h whois.lacnic.net'
alias org='whois -h whois.pir.org'
alias edu='whois -h whois.educause.edu'
alias cctld='whois -h whois.iana.org'
alias bgp='whois -h riswhois.ripe.net'

aese() {
	openssl aes-256-cbc -e -in "${1}" -out "${1}.enc"
}
