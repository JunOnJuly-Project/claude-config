#!/usr/bin/env bash
cd "$1"
DIRTY=$([ -n "$(git status --porcelain)" ] && echo dirty || echo clean)
WT_COUNT=$(git worktree list --porcelain | grep -c '^worktree ')
ORPHAN=0
if [ -d .claude/worktrees ]; then
  for d in .claude/worktrees/*/; do [ -d "$d" ] && ORPHAN=$((ORPHAN+1)); done
fi
echo "$DIRTY worktrees=$WT_COUNT orphan=$ORPHAN"
