#!/bin/bash
set -eo pipefail
ghq list | awk -F'/' '{print "git@" $1 ":" $2 "/" $3 ".git"}'
