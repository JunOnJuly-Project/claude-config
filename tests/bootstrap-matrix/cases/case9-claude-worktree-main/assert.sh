#!/usr/bin/env bash
cd "$1"
MAIN_SHA=$(git rev-parse main)
WT_SHA=$(git -C .claude/worktrees/epic-foo rev-parse HEAD)
[ "$MAIN_SHA" = "$WT_SHA" ] && echo "claude-worktree=same-as-main" || echo "claude-worktree=diverged"
