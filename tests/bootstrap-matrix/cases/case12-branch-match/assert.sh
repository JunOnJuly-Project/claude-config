#!/usr/bin/env bash
cd "$1"
HBR=$(awk '/### 현재 브랜치/{getline; print; exit}' HANDOFF.md)
ABR=$(git branch --show-current)
[ "$HBR" = "$ABR" ] && echo match || echo mismatch
