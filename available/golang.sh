#!/bin/bash

export GOPATH=${HOME}/Go
export GOROOT=${HOME}/opt/go

prepend_path PATH ${GOPATH}/bin:${GOROOT}/bin
