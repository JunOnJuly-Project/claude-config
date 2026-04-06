#!/usr/bin/env bash
# step7: 다중 블로커 (🔴 3건)
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
main
- [x] 더미
## 4. 블로커
🔴 #1 빌드 실패
🔴 #2 마이그레이션 충돌
🔴 #3 시크릿 미배포
## 5. 재개 체크리스트
- [ ] 더미
EOF
commit_all init
