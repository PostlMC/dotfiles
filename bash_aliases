alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

alias ls-la='ls -la'
alias ls-l='ls -l'

alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

alias ln-s='ln -s'

alias rm-f='rm -f'
alias rm-rf='rm -rf'

alias now="date '+%Y-%m-%dT%H:%M:%S%z'"
alias nowc="date '+%Y%m%dT%H%M%S%Z'"

alias zulu="date -u '+%Y-%m-%dT%H:%M:%S%z'"
alias zuluc="date -u '+%Y%m%dT%H%M%SZ'"

alias tmuxa='tmux -2 attach -t'
alias tmux='tmux -2'

alias html2ascii='lynx -force_html -stdin -dump -nolist'

alias g++='g++ -std=c++0x'

#alias myip="curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias myip='curl -s ifconfig.me/ip'

alias pip_upgrade_all='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U'

