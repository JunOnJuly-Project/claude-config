# CQRS — Command Query Responsibility Segregation

## 분리
- **Command**: 상태 변경. 반환값 없음(또는 ID). 쓰기 모델
- **Query**: 읽기 전용. 최적화된 읽기 모델 (뷰/프로젝션)

## 저장소 분리 (선택)
단일 DB 로 시작하여 필요 시 읽기 전용 복제본/프로젝션 테이블로 확장.

## /develop 통합
`--cqrs` 플래그 시 planner 가 Command/Query 목록을 분리 명시. `application/port/in` 을 `command/` 와 `query/` 로 분리.

## Event-Driven 조합
`--event-driven --cqrs`: Command 가 이벤트 발행 → 프로젝션 구독자가 Query 모델 갱신.
