alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

alias ls-la='ls -la'
alias ls-l='ls -l'

alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

alias ln-s='ln -s'
alias badlinks='for i in $(find . -type l); do [ -e $i ] || echo $i is broken; done'

alias rm-f='rm -f'
alias rm-rf='rm -rf'

alias now="date '+%Y-%m-%dT%H:%M:%S%z'"
alias nowc="date '+%Y%m%dT%H%M%S%Z'"

alias zulu="date -u '+%Y-%m-%dT%H:%M:%S%z'"
alias zuluc="date -u '+%Y%m%dT%H%M%SZ'"

alias tmuxa='tmux -2 attach -t'
alias tmux='tmux -2'

# WTF?
#alias tailall='find /var/log | xargs file | grep text | cut -f 1 -d : | xargs tail -F'

alias html2ascii='lynx -force_html -stdin -dump -nolist'

alias g++='g++ -std=c++0x'

#alias myip="curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias myip='curl -s ifconfig.me/ip'

alias sortips='sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n'

alias pipup='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -I {} sudo pip install -U {} --allow-external {} --allow-unverified {}'

alias apnic='whois -h whois.apnic.net'
alias ripe='whois -h whois.ripe.net'
alias arin='whois -h whois.arin.net'
alias afrinic='whois -h whois.afrinic.net'
alias lacnic='whois -h whois.lacnic.net'
alias org='whois -h whois.pir.org'
alias edu='whois -h whois.educause.edu'
alias cctld='whois -h whois.iana.org'
alias bgp='whois -h riswhois.ripe.net'
