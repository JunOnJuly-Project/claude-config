#!/usr/bin/env bash
cd "$1"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo "git" || echo "no-git"
