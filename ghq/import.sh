#!/bin/bash
set -eo pipefail

IMPORT_LIST=$1

if [[ ! -f ${IMPORT_LIST} ]]; then
    echo "File not exists."
    exit 1
fi

for url in `cat ${IMPORT_LIST}`; do
    echo "Importing ${url}..."
    ghq get ${url}
done

