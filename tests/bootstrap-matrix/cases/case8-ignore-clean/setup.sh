#!/usr/bin/env bash
# step9c: 정상 (앵커된 패턴 → false positive 방지 negative control)
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
printf "/backend/out/\n/frontend/dist/\n" > .gitignore
mkdir -p backend/src
echo "public class A {}" > backend/src/A.java
handoff_v2 > HANDOFF.md
commit_all init
echo "public class B {}" > backend/src/B.java
