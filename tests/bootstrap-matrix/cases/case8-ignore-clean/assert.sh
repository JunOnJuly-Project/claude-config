#!/usr/bin/env bash
cd "$1"
N=$(git ls-files --others -i --exclude-standard | wc -l)
U=$(git ls-files --others --exclude-standard | wc -l)
echo "ignored-untracked=$N visible-untracked=$U"
