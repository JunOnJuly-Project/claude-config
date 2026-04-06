# Event-Driven Architecture

## 핵심
- 컴포넌트 간 통신을 **이벤트 발행/구독**으로. 직접 호출 금지
- 이벤트 = 과거형 사실 (`OrderPlaced`, `PaymentFailed`)
- 버스: 인메모리(Spring `ApplicationEvent`), 메시지 브로커(Kafka/RabbitMQ)

## 보장 수준
- At-least-once: 중복 처리 가능성 → 멱등성 필수
- Eventual consistency: 트랜잭션 경계 분리

## /develop 통합
`--event-driven` 플래그 시 planner 가 이벤트 카탈로그를 먼저 정의. developer 는 발행자/구독자를 분리 커밋.
