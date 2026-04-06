#!/usr/bin/env bash
# step8: dirty + stale (gitignore 누락 untracked)
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
handoff_v2 > HANDOFF.md
commit_all init
mkdir -p node_modules .claude/worktrees/stale
echo "junk" > node_modules/x.js
echo "junk" > .claude/worktrees/stale/y.txt
echo "modified" >> HANDOFF.md
