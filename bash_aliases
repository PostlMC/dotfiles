alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

alias now="date '+%Y-%M-%dT%H:%M:%S%z'"
alias nowc="date '+%Y%M%dT%H%M%S%Z'"

alias zulu="date -u '+%Y-%M-%dT%H:%M:%S%z'"
alias zuluc="date -u '+%Y%M%dT%H%M%SZ'"

alias tmuxa='tmux -2 attach -t'
alias tmux='tmux -2'

alias html2ascii='lynx -force_html -stdin -dump -nolist'

alias g++="g++ -std=c++0x"

alias myip="curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"