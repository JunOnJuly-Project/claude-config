# TDD — Test-Driven Development

## 사이클
1. **Red**: 실패하는 테스트를 먼저 작성 (컴파일 에러도 Red)
2. **Green**: 테스트 통과 최소 구현 (하드코딩 허용)
3. **Refactor**: 중복 제거, 네이밍 개선. 테스트는 계속 통과

## 커밋 규칙
단계별 별도 커밋: `test(...)` → `feat(...)` → `refactor(...)`

## 커버리지
도메인 로직 80%+, L3 는 90%+

## /develop 통합
`--tdd` 플래그 시 tester 가 developer 보다 **먼저** 호출된다.
