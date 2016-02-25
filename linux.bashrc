if grep -qi "ID.*=debian" /etc/*release; then
    alias aptup='sudo apt-get update; sudo apt-get upgrade'
fi
