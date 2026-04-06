---
name: bdd
description: Behavior-Driven Development 적용. Given/When/Then 시나리오 기반 개발, 비즈니스 요구사항 중심 테스트가 필요할 때 사용하세요.
---

# Behavior-Driven Development (BDD)

비즈니스 요구사항을 Given/When/Then 시나리오로 표현하고 이를 기반으로 개발합니다.

## 입력
`$ARGUMENTS` — 구현할 기능 또는 시나리오

## 핵심 개념

### 시나리오 형식 (Gherkin)
```gherkin
기능: {기능 이름}
  {기능에 대한 설명}

  시나리오: {시나리오 이름}
    전제: {사전 조건 — Given}
    만약: {실행할 행위 — When}
    그러면: {기대 결과 — Then}
```

### 한국어 시나리오 예시
```gherkin
기능: 사용자 로그인
  사용자가 올바른 인증 정보로 시스템에 접근할 수 있어야 한다

  시나리오: 유효한 이메일과 비밀번호로 로그인
    전제: "user@example.com" 이메일로 가입한 사용자가 존재한다
    그리고: 비밀번호가 "Password123!" 이다
    만약: 이메일 "user@example.com"과 비밀번호 "Password123!"로 로그인을 시도한다
    그러면: 로그인에 성공한다
    그리고: JWT 토큰을 반환한다

  시나리오: 잘못된 비밀번호로 로그인
    전제: "user@example.com" 이메일로 가입한 사용자가 존재한다
    만약: 이메일 "user@example.com"과 비밀번호 "wrong"으로 로그인을 시도한다
    그러면: 로그인에 실패한다
    그리고: "비밀번호가 올바르지 않습니다" 에러를 반환한다
```

## BDD 워크플로우

### 1. 발견 (Discovery)
- 비즈니스 요구사항에서 시나리오 도출
- 정상 경로 + 대안 경로 + 예외 경로

### 2. 정의 (Formulation)
- 시나리오를 Given/When/Then으로 구조화
- 한국어로 작성
- `docs/features/` 디렉토리에 `.feature` 파일 저장

### 3. 자동화 (Automation)
- 시나리오를 실행 가능한 테스트로 변환

JavaScript (jest/vitest):
```javascript
describe('사용자 로그인', () => {
  describe('유효한 이메일과 비밀번호로 로그인', () => {
    it('전제: 가입한 사용자가 존재한다', () => { /* setup */ });
    it('만약: 로그인을 시도한다', () => { /* action */ });
    it('그러면: JWT 토큰을 반환한다', () => { /* assertion */ });
  });
});
```

Python (pytest-bdd):
```python
@scenario('login.feature', '유효한 이메일과 비밀번호로 로그인')
def test_valid_login():
    pass

@given('가입한 사용자가 존재한다')
def registered_user():
    return create_user("user@example.com", "Password123!")

@when('로그인을 시도한다')
def try_login(registered_user):
    return login("user@example.com", "Password123!")

@then('JWT 토큰을 반환한다')
def verify_token(try_login):
    assert try_login.token is not None
```

## 독립 사용 시
- `/bdd 로그인 기능` — 시나리오 작성 + 테스트 자동화
- `/bdd 시나리오 분석` — 기존 코드에서 BDD 시나리오 도출

## `/develop`과 조합 시
- Phase 3에서 Given/When/Then 시나리오 기반 테스트 작성

## 출력
- 모든 시나리오 **한국어** 작성
- `.feature` 파일 + 테스트 코드 생성
