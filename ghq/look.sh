#!/bin/bash
set -eo pipefail

query_arg=$1
target_path=$(ghq list -p | peco --on-cancel error --query "${query_arg}")
if [[ $? -ne 0 ]]; then
    exit 1
fi
echo "Changing current directory to ${target_path}"
cd ${target_path}