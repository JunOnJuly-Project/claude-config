#!/usr/bin/env bash
cd "$1"
REGISTERED=$(git worktree list --porcelain | awk '/^worktree /{print $2}')
ORPHAN=0
for d in .claude/worktrees/*/; do
  [ -d "$d" ] || continue
  abs=$(cd "$d" && pwd)
  echo "$REGISTERED" | grep -qF "$abs" || ORPHAN=$((ORPHAN+1))
done
echo "orphan=$ORPHAN"
