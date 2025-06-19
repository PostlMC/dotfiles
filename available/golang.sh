#!/bin/bash

command -v go >/dev/null 2>&1 || return

export GOPATH=${HOME}/Go
export GOROOT=${HOME}/opt/go

prepend_path PATH ${GOPATH}/bin:${GOROOT}/bin
