#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
BIN_DIR=${HOME}/bin

while true; do
    read -p "Creting symlink to ${BIN_DIR}. OK? [Y/n]" ans
    case ${ans} in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no."; exit;;
    esac
done

for d in `ls -1 ${SCRIPT_DIR}`; do
    if [[ -d ${d} ]]; then
        for f in `find ${d} -type f -regex "^[^_]*.sh$"`; do
            link_name=`basename ${f} | cut -d. -f1`
            ln -snvf ${SCRIPT_DIR}/${f} ${BIN_DIR}/${link_name}
        done
    fi
done