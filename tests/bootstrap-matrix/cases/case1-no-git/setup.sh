#!/usr/bin/env bash
# step1: git 저장소 아님
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
echo "no git here" > README.txt
