#!/usr/bin/env bash
# step9b: bin/ 휴리스틱 경고 트리거
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
echo "bin/" > .gitignore
mkdir -p src/domain/bin
echo "export const x=1" > src/domain/bin/util.ts
handoff_v2 > HANDOFF.md
git add .gitignore HANDOFF.md
git -c user.email=t@t -c user.name=t commit -q -m init
