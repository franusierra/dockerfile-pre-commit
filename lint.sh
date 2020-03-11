#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

export PATH=$PATH:/usr/local/bin

if ! which hadolint &>/dev/null; then
    >&2 echo 'hadolint command not found'
    if [ -z "$(command -v brew)" ]; then
        if [ -z "$(command -v curl)"]; then
            curl -o /usr/local/bin https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Darwin-x86_64
        else
            >&2 echo "Can't install hadolint in this machine, proceding to exit"
            exit 1
        fi
    else
        brew install hadolint
    fi
    
    
fi

hadolint "$@"
