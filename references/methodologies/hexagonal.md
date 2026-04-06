# Hexagonal Architecture (Ports & Adapters)

## 구조
- **도메인 중심**: 비즈니스 로직은 중앙에
- **Driving 포트 (in)**: 유스케이스 인터페이스 (UI/API 가 호출)
- **Driven 포트 (out)**: 외부 의존 인터페이스 (DB/외부 API)
- **어댑터**: 각 포트의 구체 구현

## Clean Arch 와의 차이
Clean Arch 는 계층이 여러 개, Hexagonal 은 포트/어댑터 두 방향만 강조. 실전에서 거의 같음.

## /develop 통합
`--hexagonal` 플래그 시 planner 가 in/out 포트 목록을 먼저 정의하고 어댑터 매핑을 제시한다.
