#!/usr/bin/env bash
# step5: claude/* 워크트리가 main HEAD 와 동일 SHA
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
handoff_v2 > HANDOFF.md
commit_all init
git -c user.email=t@t -c user.name=t worktree add -q .claude/worktrees/epic-foo -b claude/epic-foo main
