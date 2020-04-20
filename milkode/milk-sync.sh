#!/bin/bash
export RBENV_VERSION=2.6.5
export THOR_SILENCE_DEPRECATION=true

for repo in `ghq list`;
do
  add_result=`milk add "$(ghq root)/${repo}"`
  echo ${add_result}
  if [[ ! -z ` echo ${add_result} | grep "^\[error\]"` ]]; then
    echo "milk update for ${repo} started."
    milk update `basename ${repo}`
  fi
done
