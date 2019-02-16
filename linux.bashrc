#!/bin/bash

if grep -qi "ID.*=debian" /etc/*release
then
    alias apt-up='sudo -E apt-get update; sudo -E apt-get upgrade'
fi
