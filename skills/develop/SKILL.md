---
name: develop
description: 전체 개발 워크플로우. 에이전트 팀을 순차 호출하여 계획→문서→테스트→구현→리뷰→문서갱신→커밋을 수행. 방법론 플래그(--tdd, --ddd, --clean-arch, --hexagonal, --bdd, --event-driven, --cqrs, --fp, --microservice)와 --solo(비상 우회) 지원.
---

# /develop — 에이전트 팀 개발 파이프라인

## 호출 형식
```
/develop [--{방법론}...] [--solo] {도메인} {기능 설명}
```

예:
```
/develop --tdd --clean-arch auth JWT 로그인
/develop --ddd order 주문 생성
/develop --solo docs README 오타 수정
```

## 전제 조건 (자동 수행)
1. **`/bootstrap` 먼저 호출**. 실패 시 중단
2. `git status` clean 확인
3. `feature/{도메인}/{기능-kebab}` 브랜치 생성/체크아웃

## 파이프라인 (11 단계)

| 단계 | 에이전트 | 목적 | 스킵 조건 |
|---|---|---|---|
| 1 | planner | 작업 분해, 아키텍처 결정 | `--solo` |
| 2 | documenter | ADR/API 초안 | `--solo` |
| 3 | tester | 실패 테스트 (`--tdd` 면 먼저) | - |
| 4 | developer | 최소 구현 | - |
| 5 | tester | 테스트 실행, 커버리지 | - |
| 6 | reviewer | 코드 리뷰 ([치명적]/[중요]/[제안]/[칭찬]) | - |
| 7 | developer | 리뷰 피드백 반영 (최대 2 라운드) | 통과 시 |
| 8 | tester | 회귀 테스트 | - |
| 9 | documenter | README/CHANGELOG/HANDOFF 갱신 | - |
| 10 | (main) | 논리 단위 커밋 | - |
| 11 | (main) | 원격 푸시 | 원격 없음 |

## 방법론 플래그 처리
각 플래그는 `references/methodologies/{플래그}.md` 를 읽어 해당 단계 지시사항을 보강:
- `--tdd`: 단계 3 을 단계 4 앞으로
- `--clean-arch`: 단계 1 에서 port/in/out 구조 명시, 단계 6 에서 의존성 검증
- `--ddd`: 단계 1 에서 바운디드 컨텍스트 지도

## `--solo` 비상 우회
단순 오타 수정 등 명백히 안전한 경우만. planner/documenter/reviewer 스킵하고 developer 단독. **L3 도메인 금지**.

## 리뷰 피드백 루프
[치명적]/[중요] 반환 시 developer 재호출. **최대 2 라운드**. 초과 시 중단.

## 실패 처리
단계 실패 시 다음으로 진행하지 않고 보고. 자동 재시도 금지.

## 완료 출력
```
## /develop 완료: {도메인}/{기능}
- 브랜치: feature/...
- 커밋: {해시}
- 리뷰 라운드: {N}
- 푸시: {성공|실패}
```
