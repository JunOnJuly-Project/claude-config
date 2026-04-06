# BDD — Behavior-Driven Development

## Gherkin 시나리오
```
Given {초기 상태}
When {행동}
Then {기대 결과}
```

## /develop 통합
`--bdd` 플래그 시 planner 가 시나리오를 먼저 작성하고, tester 가 이를 실행 가능한 테스트(Cucumber/JBehave 또는 일반 단위 테스트의 given/when/then 주석)로 변환한다.

## TDD 와 중복
`--tdd --bdd` 동시 사용 시 BDD 시나리오를 TDD Red 단계의 실패 테스트로 사용.
