#!/usr/bin/env bash
# step9a: out/ 비앵커 패턴이 port/out/Foo.java 사일런트 무시
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
echo "out/" > .gitignore
mkdir -p backend/src/main/java/com/app/port/out
echo "package com.app.port.out; public interface Foo {}" > backend/src/main/java/com/app/port/out/Foo.java
handoff_v2 > HANDOFF.md
git add .gitignore HANDOFF.md
git -c user.email=t@t -c user.name=t commit -q -m init
