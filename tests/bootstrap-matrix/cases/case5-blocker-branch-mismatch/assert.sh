#!/usr/bin/env bash
cd "$1"
HBR=$(awk '/### 현재 브랜치/{getline; print; exit}' HANDOFF.md)
ABR=$(git branch --show-current)
[ "$HBR" = "$ABR" ] && M=match || M=mismatch
B=$(grep -c '^🔴' HANDOFF.md)
echo "$M blockers=$B"
