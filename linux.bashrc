if grep -qi "ID.*=debian" /etc/*release
then
    alias apt-up='sudo apt-get update; sudo apt-get upgrade'
fi

alias pip-up='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -I {} sudo -EH pip install -U {}'
alias pip3-up='pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -I {} sudo -EH pip3 install -U {}'
