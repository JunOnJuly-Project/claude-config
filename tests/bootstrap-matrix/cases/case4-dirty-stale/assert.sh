#!/usr/bin/env bash
cd "$1"
DIRTY=$([ -n "$(git status --porcelain)" ] && echo dirty || echo clean)
STALE=$([ -d .claude/worktrees/stale ] && echo stale || echo nostale)
echo "$DIRTY $STALE"
