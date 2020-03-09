#!/bin/bash
export RBENV_VERSION=2.6.5
export THOR_SILENCE_DEPRECATION=true

if [[ "$1" == "-a" ]];then

  milk grep -a $@

elif [[ -z `milk info $(basename $(pwd)) | grep "^Not found"` ]]; then
  echo "Searching from $(basename $(pwd)). (This will active when your at directory which is registrated to milkode.)"
  milk grep -p $(basename $(pwd)) $@

else
  echo "Searching from whole milkode db. (If you want to filter by package name. Please add -p \${package_name} option.)"
  milk grep -a $@

fi
