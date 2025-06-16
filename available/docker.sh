#!/bin/bash

# Check for Docker or Podman
if command -v docker &>/dev/null; then
    # Common aliases that work with both Docker and Podman
    alias dpql='docker ps -ql'
    alias dpsa='docker ps -a'
    alias dimgsize='docker images 2>&1 | awk '\''{sum+=$(NF-1)}END{print sum,"MB"};'\'''

    alias lookl33t='docker run -t --rm --name hollywood --net none jess/hollywood; docker rm -f hollywood; clear'

    ## This is potentially dangerous as it deletes volumes!
    alias docker-clean='docker rm $(docker ps -q -f "status=exited") 2>/dev/null \
        docker rmi $(docker images -q -f "dangling=true") 2>/dev/null \
        docker volume rm $(docker volume ls -q -f "dangling=true")  2>/dev/null'

    # Docker functions
    docker-flatten() {
        docker export $(docker run -d ${1} /bin/bash) | docker import – ${2}
    }

    ## Found at: http://stackoverflow.com/questions/24481564/how-can-i-find-docker-image-with-specific-tag-in-docker-registry-in-docker-comma
    docker-tags() {
        curl -s -S "https://registry.hub.docker.com/v2/repositories/$@/tags/" | jq '."results"[]["name"]' | sort
    }

    ## Check the balance of Docker's wonderful rate limit
    docker-rl() {
        TOKEN=$(curl -s "https://auth.docker.io/token?service=registry.docker.io&scope=repository:ratelimitpreview/test:pull" | jq -r .token)
        curl --head -H "Authorization: Bearer $TOKEN" https://registry-1.docker.io/v2/ratelimitpreview/test/manifests/latest 2>&1 |
            grep ratelimit-
    }

    # If Podman is available, set up the socket path
    if command -v podman &>/dev/null; then
        export DOCKER_HOST=unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')
    fi
fi
