#!/bin/bash

if command -v kubectl >/dev/null 2>&1; then

    source <(kubectl completion zsh)

    alias k='kubectl'
    alias kv='kubectl -v=7'
    alias kv8='kubectl -v=8'

    alias ktaints='kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints'

    alias kctx='kubectl config use-context'

    alias kimg="kubectl get pods --all-namespaces -o json | jq -r '.items[].spec.containers[].image' | sort | uniq -c"
    alias kans='kubectl get --all-namespaces $(kubectl api-resources | awk '\''$4~/true/{printf "%s ", $1}'\'')'

    ka() { kubectl "$@" --all-namespaces; }
    knh() { kubectl "$@" --no-headers; }
    kf() { kubectl "$@" --grace-period=0 --force; }
    kdr() { kubectl "$@" --dry-run=client -o yaml; }
    ke() { kubectl explain "${1}" --recursive | less; }

    kcfg() {
        if [ -d ~/.kube ] && [ -s ~/.kube/current-context ]; then
            echo ~/.kube/current-context:$(find ~/.kube -maxdepth 1 -type f \
                \( -name '*.yml' -o -name '*.yaml' \) ! -name '.*' ! -name '_*' | tr '\n' ':')
        fi
    }

    kns() { kubectl config set-context --current --namespace="${1}"; }
fi

export KUBECONFIG=$(kcfg)

# whence -w minikube >/dev/null 2>&1 &&
#     # minikube config set vm-driver hyperkit && \
#     alias mk='KUBECONFIG=${HOME}/.kube/minikube.yml minikube' &&
#     export MINIKUBE_IN_STYLE=false

command -v kubelogin >/dev/null 2>&1 && source <(kubelogin completion zsh)
