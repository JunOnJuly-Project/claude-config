#!/usr/bin/env bash
# step2: HANDOFF.md 없음
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
echo "x" > README.md
commit_all init
