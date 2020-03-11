#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

export PATH=$PATH:/usr/local/bin

if ! which hadolint &>/dev/null; then
    >&2 echo 'Hadolint command not found, trying to install...'
    if [ -z "$(command -v brew)" ]; then
        if [ -z "$(command -v curl)"]; then
            >&2 echo "Can't install hadolint in this machine, proceding to exit"
            exit 1
        else
            >&2 echo "Installing using curl"
            >&2 curl -o ~/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Darwin-x86_64
            chmod +x ~/hadolint
            >&2 ~/hadolint "$@"
            exit 0
        fi
    else
        >&2 echo "Installing using brew"
        brew install hadolint
       
    fi
    
    
fi

 >&2 echo "Executing hadolint"
 >&2 hadolint "$@"