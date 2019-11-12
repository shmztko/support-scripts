#!/bin/bash
set -eo pipefail

export WORKING_REPOS_DIR="${HOME}/workspace/repos"
# if [[ ! -d ${WORKING_REPOS_DIR} ]]; then
#     echo "Please set environment variable WORKING_REPOS_DIR." >&2
#     exit 1
# fi

sub_command=$1
if [[ -z ${sub_command} ]]; then
    echo "Sub command required. Choices are (set or unset)" >&2
    exit 1
fi

query_arg=$2
if [[ "${sub_command}" == "set" ]]; then

    target_path=$(ghq list -p | peco --on-cancel error --query "${query_arg}")
    if [[ $? -ne 0 ]]; then
        exit 1
    fi
    if [[ ! -d ${target_path} ]]; then
        echo "Target path ${target_path} not exists." >&2
        exit 1
    fi
    ln -snvf ${target_path} ${WORKING_REPOS_DIR}/

elif [[ "${sub_command}" == "unset" ]]; then
    target_path="${WORKING_REPOS_DIR}/$(ls -1 ${WORKING_REPOS_DIR} | peco --on-cancel error --query "${query_arg}")"
    if [[ $? -ne 0 ]]; then
        exit 1
    fi
    if [[ ! -d ${target_path} ]]; then
        echo "Target path ${target_path} not exists." >&2
        exit 1
    fi
    unlink ${target_path}

else
    echo "Unknown sub command. Choices are (set or unset)" >&2
    exit 1
fi