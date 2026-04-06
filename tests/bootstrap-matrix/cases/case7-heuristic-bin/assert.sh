#!/usr/bin/env bash
cd "$1"
N=$(git ls-files --others -i --exclude-standard | wc -l)
H=$(grep -E '^(bin|dist|target|out)/' .gitignore | head -1)
echo "ignored-untracked=$N heuristic=$H"
