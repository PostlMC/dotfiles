#!/bin/bash

command -v terraform >/dev/null 2>&1 || return

alias tf='terraform'
alias tfv='TF_LOG=INFO terraform'
alias tfvv='TF_LOG=TRACE terraform'

complete -o nospace -C "$(command -v terraform)" terraform

command -v terragrunt >/dev/null 2>&1 && alias tg='terragrunt'
