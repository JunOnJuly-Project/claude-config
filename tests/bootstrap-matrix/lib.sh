#!/usr/bin/env bash
# 공통 헬퍼: 각 케이스 setup 스크립트가 source 한다.
set -euo pipefail

GIT_AUTHOR_NAME=test
GIT_AUTHOR_EMAIL=t@t
GIT_COMMITTER_NAME=test
GIT_COMMITTER_EMAIL=t@t
export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL

handoff_v2() {
  cat <<'EOF'
# 프로젝트 핸드오프
> 스키마 버전: v2
## 1. 개요
test fixture
## 2. 실행
test
## 3. 현재 진행 상태
### 현재 브랜치
main
- [x] 더미
## 4. 블로커
🟢 없음
## 5. 재개 체크리스트
- [ ] 더미
EOF
}

handoff_v1() {
  cat <<'EOF'
# 프로젝트 핸드오프 (구버전)
## 개요
스키마 버전 표기 없음 (v1)
## 진행
- [x] 더미
EOF
}

reset_dir() {
  local dir="$1"
  rm -rf "$dir"
  mkdir -p "$dir"
}

git_init_main() {
  git init -q -b main
}

commit_all() {
  git add -A
  git -c user.email=t@t -c user.name=t commit -q -m "$1"
}
