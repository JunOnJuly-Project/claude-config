#!/usr/bin/env bash
# step5 diverged: claude/* 워크트리가 main 보다 앞선 정상 작업 상태
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
handoff_v2 > HANDOFF.md
commit_all init
git -c user.email=t@t -c user.name=t worktree add -q .claude/worktrees/epic-foo -b claude/epic-foo main
(
  cd .claude/worktrees/epic-foo
  echo "work" > work.txt
  git -c user.email=t@t -c user.name=t add work.txt
  git -c user.email=t@t -c user.name=t commit -q -m "wip"
)
