#!/bin/bash
function open_in_github() {
    TARGET=$1
    if [ ! -f "${TARGET}" ] && [ ! -d "${TARGET}" ]; then
        echo "Given file or directory doesn't exists." >&2
        usage_exit
    fi
    if [ -z $(git rev-parse --git-dir 2> /dev/null) ]; then
        echo "You are not in git repository." >&2
        usage_exit
    fi
    if [ -z $(printenv GITHUB_HOST) ];then
        echo "GITHUB_HOST should be added to env valiables." >&2
        usage_exit
    fi

    PROTOCOL="https://"
    REPONAME=$(git rev-parse --show-toplevel | rev | cut -d / -f1,2 | rev)
    PREFIX=$(git rev-parse --show-prefix)
    BRANCH=$(git symbolic-ref --short HEAD)

    if [ -d ${TARGET} ]; then
        github_url="${PROTOCOL}${GITHUB_HOST}/${REPONAME}/tree/${BRANCH}/${PREFIX}${TARGET}"
    elif [ -f ${TARGET} ]; then
        github_url="${PROTOCOL}${GITHUB_HOST}/${REPONAME}/blob/${BRANCH}/${PREFIX}${TARGET}"
    else
        echo "Target file should be directory or file. other types can not handle by this script." >&2
        usage_exit
    fi

    if [ ${SHOW_URL_ONLY} -eq 1 ]; then
        echo "${github_url}"
    else
        echo "Opening ${REPONAME}:${PREFIX}${TARGET} in github" >&2
        open ${github_url}
    fi
}

function usage_exit() {
    echo "This scripts show github file on browser." >&2
    echo "Usage: $0 [-s] file_path" >&2
    echo "-s : only show url to stdout" >&2
    exit 1
}

while getopts sh OPT
do
    case $OPT in
        s)  SHOW_URL_ONLY=1
            ;;
        h)  usage_exit
            ;;
        \?) usage_exit
            ;;
    esac
done
shift $((OPTIND - 1))
open_in_github $@