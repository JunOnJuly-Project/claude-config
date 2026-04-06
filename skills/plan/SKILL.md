---
name: plan
description: 프로젝트 계획 및 작업 분해. 새 프로젝트 시작, 기능 기획, 아키텍처 설계, 작업 분해 시 사용. 브레인스토밍 3라운드(델파이)로 planner/developer/tester/reviewer 에이전트의 관점을 통합한다.
---

# /plan — 계획 및 브레인스토밍

## 호출 형식
```
/plan [--brainstorm] {프로젝트/기능 설명}
```

## 파이프라인
1. **`/bootstrap`** 전제 검증
2. **Phase -1 인터뷰** — 필수 정보: 목적, 사용자, 핵심 기능. 부족 시 최대 3 회 재질문
3. **Phase 0 브레인스토밍 (3 라운드 델파이)**
   - 라운드 1: planner/developer/tester/reviewer 병렬 관점 수집
   - 라운드 2: 교차 검토, 상호 피드백
   - 라운드 3: planner 최종 통합, 나머지 검증
4. **Phase 1 계획서 작성** — `docs/plans/{프로젝트}-plan.md` 생성
5. **Phase 2 HANDOFF 갱신** — `/handoff update progress`
6. 사용자 승인 → 커밋

## 출력
- `docs/plans/{name}-plan.md`
- 작업 분해 (Epic → Story → Task, 각각 GitHub 이슈 후보)
- 리스크 목록
