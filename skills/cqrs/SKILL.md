---
name: cqrs
description: CQRS (Command Query Responsibility Segregation) 적용. 읽기/쓰기 모델 분리, 커맨드/쿼리 분리가 필요할 때 사용하세요.
---

# CQRS (Command Query Responsibility Segregation)

커맨드(쓰기)와 쿼리(읽기)의 책임을 분리합니다.

## 입력
`$ARGUMENTS` — 설계/구현할 기능 또는 CQRS 적용 대상

## 핵심 개념

### 커맨드 (Command)
- 시스템 상태를 **변경**하는 요청
- 반환값 없음 (또는 ID만 반환)
- 네이밍: `CreateOrder`, `UpdateProfile`, `DeleteItem`
- 유효성 검증 → 비즈니스 로직 → 상태 변경

### 쿼리 (Query)
- 시스템 상태를 **조회**하는 요청
- 상태를 변경하지 않음
- 네이밍: `GetOrderById`, `ListUserOrders`, `SearchProducts`
- 읽기 최적화된 모델 사용

### 분리의 이점
- 읽기/쓰기 독립적 스케일링
- 각각에 최적화된 데이터 모델
- 복잡한 도메인에서 명확한 의도 표현

## 디렉토리 구조
```
src/
├── commands/                # 커맨드 (쓰기)
│   ├── {command}/
│   │   ├── command.ts       # 커맨드 정의
│   │   ├── handler.ts       # 커맨드 핸들러
│   │   └── validator.ts     # 유효성 검증
│   └── bus.ts               # 커맨드 버스
├── queries/                 # 쿼리 (읽기)
│   ├── {query}/
│   │   ├── query.ts         # 쿼리 정의
│   │   ├── handler.ts       # 쿼리 핸들러
│   │   └── read-model.ts    # 읽기 모델
│   └── bus.ts               # 쿼리 버스
├── domain/                  # 도메인 모델 (쓰기 모델)
│   ├── aggregates/
│   └── events/
└── read-models/             # 읽기 모델 (비정규화)
    └── projections/         # 이벤트 → 읽기 모델 변환
```

## 구현 패턴

### 기본 CQRS (단일 DB)
```
[클라이언트] → 커맨드 → 커맨드 핸들러 → 도메인 모델 → DB
[클라이언트] → 쿼리 → 쿼리 핸들러 → 읽기 모델 → DB (같은 DB)
```

### 분리 DB CQRS
```
[클라이언트] → 커맨드 → 핸들러 → 쓰기 DB
                              → 이벤트 발행
                              → 프로젝션 → 읽기 DB
[클라이언트] → 쿼리 → 핸들러 → 읽기 DB
```

## Event Sourcing + CQRS 조합 시
- 커맨드: 이벤트 생성 → 이벤트 저장소에 저장
- 쿼리: 이벤트를 프로젝션하여 읽기 모델 생성
- `/event-driven`과 함께 사용 권장

## 독립 사용 시
- `/cqrs 설계` — 커맨드/쿼리 분리 설계
- `/cqrs 구현` — CQRS 패턴 구현

## 출력
- 모든 출력 **한국어**
- 커맨드/쿼리 목록 및 흐름도
