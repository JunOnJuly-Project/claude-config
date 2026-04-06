---
name: fp
description: Functional Programming 패턴 적용. 순수 함수, 불변성, 함수 합성, 사이드 이펙트 격리가 필요할 때 사용하세요.
---

# Functional Programming (FP)

함수형 프로그래밍 원칙으로 예측 가능하고 테스트하기 쉬운 코드를 작성합니다.

## 입력
`$ARGUMENTS` — 구현할 기능 또는 FP 패턴 적용 대상

## 핵심 원칙

### 1. 순수 함수 (Pure Function)
- 같은 입력 → 항상 같은 출력
- 사이드 이펙트 없음 (외부 상태 변경 X)
- 테스트 용이, 추론 가능

```javascript
// 순수 함수 (O)
const calculateTotal = (items) =>
  items.reduce((sum, item) => sum + item.price * item.quantity, 0);

// 비순수 함수 (X)
let total = 0;
const addToTotal = (item) => { total += item.price; };
```

### 2. 불변성 (Immutability)
- 데이터를 직접 수정하지 않고 새 복사본 생성
- 예측 불가능한 상태 변경 방지

```javascript
// 불변 (O)
const addItem = (cart, item) => [...cart, item];

// 가변 (X)
const addItem = (cart, item) => { cart.push(item); return cart; };
```

### 3. 함수 합성 (Composition)
- 작은 함수를 조합하여 복잡한 연산 구축
- 파이프라인 패턴

```javascript
const pipe = (...fns) => (x) => fns.reduce((v, f) => f(v), x);

const processOrder = pipe(
  validateOrder,     // 주문 검증
  calculateTotal,    // 합계 계산
  applyDiscount,     // 할인 적용
  addTax             // 세금 추가
);
```

### 4. 고차 함수 (Higher-Order Function)
- 함수를 인자로 받거나 함수를 반환
- `map`, `filter`, `reduce` 활용

### 5. 사이드 이펙트 격리
- IO, DB, API 호출 등을 경계로 분리
- 순수 로직 ↔ 사이드 이펙트 분리

```
[입력] → 순수 변환 로직 → [출력]
                            ↓
                    사이드 이펙트 (DB, API)
```

## FP 패턴

### Option/Maybe (null 안전)
```javascript
const findUser = (id) => users.find(u => u.id === id)
  ? Some(user) : None;

findUser(1)
  .map(user => user.name)
  .getOrElse('익명');
```

### Either (에러 처리)
```javascript
const divide = (a, b) =>
  b === 0 ? Left('0으로 나눌 수 없습니다') : Right(a / b);
```

### 커링 (Currying)
```javascript
const multiply = (a) => (b) => a * b;
const double = multiply(2);
double(5); // 10
```

## 디렉토리 구조 (FP 스타일)
```
src/
├── core/                   # 순수 함수 (비즈니스 로직)
│   ├── transformers/       # 데이터 변환 함수
│   ├── validators/         # 검증 함수
│   └── calculators/        # 계산 함수
├── effects/                # 사이드 이펙트
│   ├── io/                 # 파일/네트워크 IO
│   ├── db/                 # DB 연산
│   └── api/                # 외부 API
├── types/                  # 타입 정의 (Option, Either 등)
└── pipelines/              # 함수 합성 파이프라인
```

## 독립 사용 시
- `/fp 데이터 처리` — FP 패턴으로 데이터 처리 구현
- `/fp 리팩토링` — 기존 명령형 코드를 함수형으로 전환

## 출력
- 모든 출력 **한국어**
