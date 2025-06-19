#!/bin/bash

command -v openssl >/dev/null 2>&1 || return

# OpenSSL aliases
alias rsa='openssl rsa -noout -text'
alias dtls1='echo | openssl s_client -dtls1 -connect'
alias pkcs12='openssl pkcs12 -nomacver -nodes'
alias sclient='echo | openssl s_client -connect'
alias ssl2='echo | openssl s_client -ssl2 -connect'
alias ssl3='echo | openssl s_client -ssl3 -connect'
alias tls1_1='echo | openssl s_client -tls1_1 -connect'
alias tls1_2='echo | openssl s_client -tls1_2 -connect'
alias tls1='echo | openssl s_client -tls1 -connect'
alias x509='openssl x509 -noout -text'

# OpenSSL functions
get-chain() {
    echo | openssl s_client -connect ${1}:${2:-443} -showcerts 2>/dev/null |
        awk '/-----BEGIN/{out=sprintf("'${1}'-%02d.cer",++count); p=1} /-----END/ {print > out; p=0} p {print > out}'
}

cert2key() {
    N=$( (
        openssl x509 -in $1 -noout -modulus |
            openssl md5
        openssl rsa -in $2 -noout -modulus | openssl md5
    ) | uniq | wc -l)
    if [ $N == 1 ]; then
        echo "Cert and key MATCH"
    else
        echo "Cert and key DO NOT MATCH"
    fi
}

show-p12cert() { openssl pkcs12 -in $1 -nokeys -clcerts | openssl x509 -noout -text; }

dump-p7certs() { openssl pkcs7 -in $1 -print_certs |
    awk '/-----BEGIN/ {out=sprintf("'${1%.*}'-%02d.cer",++count); p=1} /-----END/ {print > out; p=0} p {print > out}'; }

fix-cert-name() {
    # Check if we have GNU sed (required for lowercase conversion)
    if sed --version 2>/dev/null | grep -q "GNU sed"; then
        openssl x509 -in "${1}" -noout -subject |
            awk -F' = ' '{print $NF}' |
            sed '
                s/.*/\L&/        # convert to lowercase (requires GNU sed!)
                s/ - */-/g       # condense hyphenations
                s/^\*/WILDCARD/  # label wildcards
                s/[)]$//         # drop trailing parens
                s/ [(]/_/g       # condense/replace leading parens
                s/[ :/()*]/_/g   # replace misc chars with underscore
            '
    else
        # Fallback for BSD sed (macOS)
        openssl x509 -in "${1}" -noout -subject |
            awk -F' = ' '{print $NF}' |
            sed '
                s/ - */-/g       # condense hyphenations
                s/^\*/WILDCARD/  # label wildcards
                s/[)]$//         # drop trailing parens
                s/ [(]/_/g       # condense/replace leading parens
                s/[ :/()*]/_/g   # replace misc chars with underscore
            ' | tr '[:upper:]' '[:lower:]'
    fi
}

aesenc() {
    openssl aes-256-cbc -e -salt -in "$1" -out "$1.enc"
}
