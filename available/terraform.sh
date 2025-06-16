#!/bin/bash

if command -v terraform >/dev/null 2>&1; then
    alias tf='terraform'
    alias tfv='TF_LOG=INFO terraform'
    alias tfvv='TF_LOG=TRACE terraform'

    if [ -f "$(command -v terraform)" ]; then
        complete -o nospace -C "$(command -v terraform)" terraform
    fi
fi

if command -v terragrunt >/dev/null 2>&1; then
    alias tg='terragrunt'
fi
