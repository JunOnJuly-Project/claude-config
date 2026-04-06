#!/usr/bin/env bash
# step4 positive: HANDOFF 브랜치와 실제 브랜치 일치
source "$(dirname "$0")/../../lib.sh"
TARGET="${1:?target dir required}"
reset_dir "$TARGET"
cd "$TARGET"
git_init_main
cat > HANDOFF.md <<'EOF'
# 프로젝트 핸드오프
> 스키마 버전: v2
## 1. 개요
test
## 2. 실행
test
## 3. 현재 진행 상태
### 현재 브랜치
feature/x/y
- [x] 더미
## 4. 블로커
🟢 없음
## 5. 재개 체크리스트
- [ ] 더미
EOF
commit_all init
git checkout -q -b feature/x/y
