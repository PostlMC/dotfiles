#!/bin/bash

command -v python >/dev/null 2>&1 || return

export PIP_REQUIRE_VIRTUALENV=true
export VIRTUAL_ENV_DISABLE_PROMPT=1

gpip() {
    PIP_REQUIRE_VIRTUALENV=false
    python -m pip "$@"
}

gpip3() {
    PIP_REQUIRE_VIRTUALENV=false
    python -m pip3 "$@"
}
