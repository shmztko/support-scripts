#!/bin/bash
TARGET=$1
if [ ! -f "${TARGET}" ] && [ ! -d "${TARGET}" ]; then
    echo "Given file or directory doesn't exists." >&2
    exit 1
fi
if [ -z $(git rev-parse --git-dir 2> /dev/null) ]; then
    echo "You are not in git repository." >&2
    exit 1
fi
if [ -z $(printenv GITHUB_HOST) ];then 
    echo "GITHUB_HOST should be added to env valiables." >&2
    exit 1
fi
PROTOCOL="https://"
REPONAME=$(git rev-parse --show-toplevel | rev | cut -d / -f1,2 | rev)
PREFIX=$(git rev-parse --show-prefix)
BRANCH=$(git symbolic-ref --short HEAD)

echo "Opening ${REPONAME}:${PREFIX}${TARGET} in github" >&2

if [ -d ${TARGET} ]; then
    open "${PROTOCOL}${GITHUB_HOST}/${REPONAME}/tree/${BRANCH}/${PREFIX}${TARGET}"
elif [ -f ${TARGET} ]; then
    open "${PROTOCOL}${GITHUB_HOST}/${REPONAME}/blob/${BRANCH}/${PREFIX}${TARGET}"
else
    echo "KOKONIKURUKOTOHANAIHAZU..." >&2
fi