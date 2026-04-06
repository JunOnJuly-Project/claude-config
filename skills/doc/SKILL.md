---
name: doc
description: 문서 생성 및 업데이트. README, API 문서, 아키텍처 문서, CHANGELOG, ADR, HANDOFF 갱신 시 사용. documenter 에이전트를 호출한다.
---

# /doc — 문서 생성/갱신

## 호출 형식
```
/doc [readme|api|adr|changelog|handoff|all] {추가 설명}
```

## 파이프라인
1. **documenter** 에이전트 호출 (한국어, 독스트링 포함)
2. 대상별 템플릿:
   - `readme` — 프로젝트 설명, 설치, 사용법, 아키텍처
   - `api` — 엔드포인트, 파라미터, 응답 예시
   - `adr` — `docs/adr/NNNN-{제목}.md` (날짜/상태/컨텍스트/결정/결과)
   - `changelog` — Keep a Changelog 형식
   - `handoff` — `/handoff update` 로 위임
3. 커밋: `docs({domain}): {한국어}`

## 트리거
`/develop` 의 단계 2, 9 에서 자동 호출.
