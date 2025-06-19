#!/bin/bash

command -v ssh-agent >/dev/null 2>&1 || return

# (Adapted from: http://mah.everybody.org/docs/ssh)
SSH_ENV="${HOME}/.ssh/environment"

start_agent() {
    #  echo "Starting SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >"${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" >/dev/null
    /usr/bin/ssh-add
}

# Now run it if needed
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" >/dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null || {
        start_agent
    }
else
    start_agent
fi
