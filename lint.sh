#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

export PATH=$PATH:/usr/local/bin
args= "$@"
echo "Executing docker linter version 1.8"
if ! which hadolint &>/dev/null; then
    echo 'Hadolint command not found, trying to install...'
    if [ -z "$(command -v brew)" ]; then
        if [ -z "$(command -v curl)" ]; then
            echo "Can't install hadolint in this machine, proceding to exit"
            exit 1
        else
            echo "Installing using curl"
            curl -o ~/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Darwin-x86_64
            echo "Hadolint instaled"
            chmod +x ~/hadolint
            echo "Running hadolint with args: $args"
            ~/hadolint $args
            exit 0
        fi
    else
        >&2 echo "Installing using brew"
        brew install hadolint 
    fi
fi

 >&2 echo "Executing hadolint"
 hadolint $args