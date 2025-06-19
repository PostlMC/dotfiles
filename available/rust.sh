#!/bin/bash

command -v rustc >/dev/null 2>&1 || return

. "${HOME}/.cargo/env"
