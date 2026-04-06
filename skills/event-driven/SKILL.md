---
name: event-driven
description: Event-Driven Architecture 적용. 이벤트 기반 설계, 이벤트 소싱, 비동기 통신이 필요할 때 사용하세요.
---

# Event-Driven Architecture (EDA)

이벤트를 중심으로 시스템을 설계하고 느슨한 결합을 달성합니다.

## 입력
`$ARGUMENTS` — 설계/구현할 기능 또는 이벤트 흐름

## 핵심 개념

### 이벤트 (Event)
- 시스템에서 발생한 **사실(Fact)** — 이미 일어난 일
- 불변, 과거형 네이밍: `OrderPlaced`, `UserRegistered`
- 이벤트 구조:
  ```
  {
    eventId: "고유ID",
    eventType: "OrderPlaced",
    timestamp: "2024-01-01T00:00:00Z",
    aggregateId: "주문ID",
    payload: { ... }
  }
  ```

### 이벤트 발행자 (Publisher/Producer)
- 이벤트를 생성하고 발행
- 누가 소비하는지 알 필요 없음

### 이벤트 구독자 (Subscriber/Consumer)
- 관심 있는 이벤트를 구독하고 처리
- 발행자와 독립적으로 동작

### 이벤트 브로커 (Broker)
- 발행자와 구독자 사이의 중개
- 예: Kafka, RabbitMQ, Redis Streams, 인메모리 버스

## 패턴

### 1. 이벤트 알림 (Event Notification)
- 가장 단순한 형태
- "무언가 발생했다"는 알림만 전달
- 소비자가 필요한 데이터는 직접 조회

### 2. 이벤트 전달 상태 전이 (Event-Carried State Transfer)
- 이벤트에 변경된 상태 데이터 포함
- 소비자가 별도 조회 불필요
- 데이터 일관성 주의

### 3. 이벤트 소싱 (Event Sourcing)
- 상태를 이벤트의 시퀀스로 저장
- 현재 상태 = 이벤트 리플레이 결과
- 완전한 감사 추적 가능

## 디렉토리 구조
```
src/
├── events/
│   ├── types/              # 이벤트 타입 정의
│   ├── bus/                # 이벤트 버스 (발행/구독)
│   ├── handlers/           # 이벤트 핸들러
│   └── store/              # 이벤트 저장소 (이벤트 소싱 시)
├── domain/
│   └── {aggregate}/
│       ├── events.ts       # 도메인 이벤트 정의
│       └── aggregate.ts    # 이벤트 발행 로직
└── infrastructure/
    └── messaging/          # 브로커 어댑터
```

## 이벤트 흐름 문서화 형식
```
[주문 생성 요청]
  → OrderService.createOrder()
    → OrderPlaced 이벤트 발행
      → InventoryHandler: 재고 차감
      → NotificationHandler: 알림 발송
      → PaymentHandler: 결제 처리
        → PaymentCompleted 이벤트 발행
          → OrderHandler: 주문 상태 업데이트
```

## 독립 사용 시
- `/event-driven 설계` — 이벤트 흐름 분석 및 설계
- `/event-driven 구현` — 이벤트 버스/핸들러 구현

## 출력
- 모든 출력 **한국어**
- 이벤트 흐름 다이어그램 (텍스트)
