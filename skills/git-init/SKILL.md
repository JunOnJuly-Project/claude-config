---
name: git-init
description: Git Flow 초기 설정. 새 프로젝트의 Git 환경 설정, 브랜치 전략 구성, 이슈/PR 템플릿 생성이 필요할 때 사용하세요.
---

# Git Flow 초기 설정

프로젝트에 Git Flow 브랜치 전략과 컨벤션을 설정합니다.

## 입력
`$ARGUMENTS` — 프로젝트 유형 (선택사항, 비어있으면 자동 감지)

## 실행 단계

### 1. Git 초기화
- git이 초기화되지 않았으면 `git init`
- 이미 초기화되었으면 기존 설정 존중

### 2. .gitignore 생성
- 프로젝트 유형 감지 (Node, Python, Java, Go 등)
- 적절한 .gitignore 생성
- `.env`, 빌드 산출물, IDE 설정 등 포함

### 3. 브랜치 구조 생성
```bash
# main 브랜치 (현재 브랜치)
git checkout -b develop
```

### 4. GitHub 이슈 템플릿 생성

`.github/ISSUE_TEMPLATE/bug_report.md`:
```markdown
---
name: 버그 리포트
about: 버그를 신고하여 개선에 기여하세요
labels: type:bug
---

## 버그 설명
{버그에 대한 명확한 설명}

## 재현 단계
1. ...
2. ...

## 기대 동작
{정상적으로 기대하는 동작}

## 실제 동작
{실제로 발생하는 동작}

## 환경
- OS:
- 런타임 버전:
- 프로젝트 버전:
```

`.github/ISSUE_TEMPLATE/feature_request.md`:
```markdown
---
name: 기능 요청
about: 새로운 기능을 제안하세요
labels: type:feature
---

## 기능 설명
{구현하고자 하는 기능에 대한 설명}

## 사용 사례
{이 기능이 필요한 상황}

## 제안 구현
{구현 방안 제안 (선택사항)}

## 수용 기준
- [ ] {기준 1}
- [ ] {기준 2}
```

### 5. PR 템플릿 생성

`.github/PULL_REQUEST_TEMPLATE.md`:
```markdown
## 변경 사항 요약
{이 PR의 핵심 변경사항}

## 변경 유형
- [ ] 새 기능 (feat)
- [ ] 버그 수정 (fix)
- [ ] 리팩토링 (refactor)
- [ ] 문서 (docs)
- [ ] 테스트 (test)

## 관련 이슈
Closes #{이슈번호}

## 테스트 방법
{변경사항을 검증하는 방법}

## 체크리스트
- [ ] 클린코드 원칙 준수
- [ ] 한국어 주석 작성
- [ ] 테스트 통과
- [ ] 문서 업데이트
```

### 6. 초기 커밋
```
chore: 프로젝트 Git 환경 초기 설정

- Git Flow 브랜치 전략 설정 (main, develop)
- 이슈/PR 템플릿 생성
- .gitignore 설정
```

## 출력
- 생성된 파일 목록 보고
- 브랜치 상태 보고
- 다음 단계 안내 (예: `/project-init`으로 GitHub Project 설정)
