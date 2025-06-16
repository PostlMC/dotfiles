#!/bin/bash

grep -qi "ID.*=debian" /etc/*release && \
    alias apt-up='sudo -E apt-get update; sudo -E apt-get upgrade'

startstat() {
    systemctl start ${*}
    systemctl status ${*}
}
