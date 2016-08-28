if grep -qi "ID.*=debian" /etc/*release
then
    alias apt-up='sudo apt-get update; sudo apt-get upgrade'
fi
