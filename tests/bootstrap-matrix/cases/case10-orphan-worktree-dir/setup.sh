#!/usr/bin/env bash
# step6: 디렉터리만 잔재 (worktree list 미등록)
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
handoff_v2 > HANDOFF.md
commit_all init
mkdir -p .claude/worktrees/orphan
echo "stale" > .claude/worktrees/orphan/junk.txt
