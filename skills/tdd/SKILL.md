---
name: tdd
description: Test-Driven Development 적용. TDD 사이클(Red→Green→Refactor)로 개발하거나, 기존 코드에 TDD를 적용할 때 사용하세요.
---

# Test-Driven Development (TDD)

Red→Green→Refactor 사이클에 따라 테스트 주도로 개발합니다.

## 입력
`$ARGUMENTS` — 구현할 기능 또는 TDD를 적용할 대상

## TDD 사이클

### Red (실패하는 테스트 작성)
1. 구현할 기능의 **기대 동작**을 테스트로 먼저 작성한다
2. 테스트명은 한국어: `it('유효한 입력이면 결과를 반환한다')`
3. 테스트를 실행하여 **실패**하는지 확인한다
4. 커밋: `test({도메인}): {테스트 설명} — Red`

### Green (최소 구현)
1. 테스트를 **통과시키기 위한 최소한의 코드**만 작성한다
2. 깔끔하지 않아도 된다 — 목표는 오직 테스트 통과
3. 테스트를 실행하여 **통과**하는지 확인한다
4. 커밋: `feat({도메인}): {기능 설명} — Green`

### Refactor (리팩토링)
1. 테스트가 통과한 상태에서 코드를 개선한다
2. 클린코드 원칙 적용 (SOLID, DRY, KISS)
3. 리팩토링 후 테스트가 **여전히 통과**하는지 확인한다
4. 커밋: `refactor({도메인}): {개선 내용} — Refactor`

### 반복
- 다음 기능/케이스에 대해 Red→Green→Refactor 반복
- 각 사이클마다 **한 가지 기능/행위**에만 집중

## 테스트 작성 가이드

### 테스트 구조
```
Arrange (준비) → Act (실행) → Assert (검증)
```

### 커버리지 대상
- **정상 경로**: 기대 동작
- **엣지 케이스**: 경계값, 빈 값, null
- **에러 조건**: 잘못된 입력, 예외 상황
- **경계값**: 최소/최대, 0, 음수

### 좋은 테스트의 특성
- **Fast**: 빠르게 실행
- **Independent**: 다른 테스트에 의존하지 않음
- **Repeatable**: 언제든 같은 결과
- **Self-Validating**: 성공/실패가 자동 판단
- **Timely**: 프로덕션 코드 전에 작성

## 독립 사용 시
`/tdd {대상}` — 기존 코드에 TDD 방식을 적용하거나, 새 기능을 TDD로 개발

## `/develop`과 조합 시
`/develop --tdd {기능}` — Phase 3에서 자동으로 Red 단계, Phase 4에서 Green, Phase 5에서 Refactor 적용

## 출력
- 모든 출력 **한국어**
- 각 사이클(Red/Green/Refactor)의 결과 보고
