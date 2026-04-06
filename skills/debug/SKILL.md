---
name: debug
description: 디버깅 워크플로우. 버그 수정, 에러 분석, 문제 해결 시 사용. debugger 에이전트로 근본 원인을 찾고 developer 가 수정, tester 가 회귀 테스트 추가, reviewer 가 검증한다.
---

# /debug — 체계적 디버깅

## 호출 형식
```
/debug {에러 메시지 또는 증상}
```

## 파이프라인
1. **`/bootstrap`** 전제 검증
2. **debugger** — 7 단계 근본 원인 분석 (재현 → 격리 → 가설 → 검증 → 수정 제안)
3. **developer** — 수정 구현
4. **tester** — 회귀 테스트 추가 (버그가 다시 발생하지 않도록)
5. **reviewer** — 수정 검증, 사이드이펙트 확인
6. 논리 단위 커밋: `fix({domain}): ...` + `test({domain}): 회귀 테스트`
7. `/handoff update blocker` 자동 호출

## 원칙
"증상 치료" 금지. 근본 원인을 찾을 때까지 커밋 금지.
