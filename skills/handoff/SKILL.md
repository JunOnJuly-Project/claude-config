---
name: handoff
description: HANDOFF.md 를 관리한다. 서브커맨드 init/update/validate/migrate 지원. 프로젝트가 다른 PC/세션에서 끊김 없이 이어받을 수 있도록 표준 스키마를 강제한다.
---

# /handoff — HANDOFF 문서 관리

## 서브커맨드

### `/handoff init`
`templates/HANDOFF.md` 를 복사하여 프로젝트 루트에 생성. 프로젝트 이름/설명/필수 도구를 인터뷰로 채운다.

### `/handoff update {섹션}`
특정 섹션만 갱신. 섹션: `progress`, `blocker`, `next`, `branch`.

**커밋 해시 자동 채우기** (신규): `progress` 갱신 시 "완료" 표의 "커밋" 열이 비어 있거나 `—` 이면 `git log --oneline -n 20` 으로 최근 커밋을 조회하여 작업 설명과 키워드 매칭하여 해시(7자) 를 자동 채운다. 매칭 실패 시 사용자에게 해시 목록 제시 후 선택.

### `/handoff validate`
`templates/handoff.schema.json` 과 대조하여 누락/오류 보고. 필수 섹션:
- 1. 프로젝트 개요
- 2. 다른 PC에서 이어받기 (필수 도구, 클론, 시크릿, 실행)
- 3. 현재 진행 상태 (완료/블로커/다음작업)
- 4. 방법론 강제 규칙
- 5. 재개 체크리스트
- 6. 참고 자료

### `/handoff migrate`
v1 → v2 변환. 구형식을 표준 스키마로 자동 변환하고 diff 를 사용자에게 보여줌.

## 트리거
- 주요 마일스톤(feature 브랜치 병합) 직후 자동 `/handoff update progress`
- 블로커 발생 시 자동 `/handoff update blocker`
- `/bootstrap` 검증 실패 시 자동 제안
