#!/usr/bin/env bash
# step5/step6/step8 정상: claude 워크트리 없음 + clean working tree + orphan 없음
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
handoff_v2 > HANDOFF.md
commit_all init
