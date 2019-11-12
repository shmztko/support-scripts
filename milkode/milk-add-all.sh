#!/bin/bash
export RBENV_VERSION=2.6.5
for i in `ghq list`; do milk add "$(ghq root)/$i" ; done
