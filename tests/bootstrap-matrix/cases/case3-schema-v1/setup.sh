#!/usr/bin/env bash
# step3: HANDOFF v1 (스키마 버전 표기 없음)
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
handoff_v1 > HANDOFF.md
commit_all init
