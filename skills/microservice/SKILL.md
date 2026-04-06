---
name: microservice
description: Microservice 패턴 적용. 서비스 분리, API 게이트웨이, 서비스 간 통신, 사가 패턴이 필요할 때 사용하세요.
---

# Microservice 패턴

독립적으로 배포 가능한 서비스 단위로 시스템을 설계합니다.

## 입력
`$ARGUMENTS` — 설계/구현할 시스템 또는 서비스

## 핵심 원칙

### 1. 서비스 경계 (Service Boundary)
- 하나의 서비스 = 하나의 비즈니스 능력 (Business Capability)
- DDD의 바운디드 컨텍스트와 일치
- 자체 데이터 저장소 소유 (Database per Service)

### 2. 독립 배포 (Independent Deployment)
- 다른 서비스 변경 없이 배포 가능
- 하위 호환성 유지
- 시맨틱 버저닝

### 3. 느슨한 결합 (Loose Coupling)
- 서비스 간 직접 의존 최소화
- API 계약(Contract) 기반 통신
- 비동기 이벤트 선호

## 통신 패턴

### 동기 통신 (Synchronous)
- **REST API**: HTTP 기반, 자원 중심
- **gRPC**: 고성능 바이너리 프로토콜
- **GraphQL**: 유연한 쿼리

### 비동기 통신 (Asynchronous)
- **이벤트 기반**: 이벤트 브로커 (Kafka, RabbitMQ)
- **메시지 큐**: 1:1 통신
- **Pub/Sub**: 1:N 통신

## 핵심 패턴

### API 게이트웨이 (API Gateway)
- 클라이언트 진입점 단일화
- 라우팅, 인증, 속도 제한, 로드 밸런싱

### 서비스 디스커버리 (Service Discovery)
- 서비스 위치 동적 탐색
- 클라이언트 사이드 / 서버 사이드

### 사가 패턴 (Saga Pattern)
- 분산 트랜잭션 관리
- **코레오그래피**: 이벤트 기반, 중앙 조율 없음
- **오케스트레이션**: 중앙 조율자가 순서 관리

### 서킷 브레이커 (Circuit Breaker)
- 장애 전파 방지
- 상태: Closed → Open → Half-Open

### 사이드카 패턴 (Sidecar)
- 공통 기능(로깅, 모니터링)을 별도 프로세스로 분리

## 디렉토리 구조 (모노레포)
```
services/
├── api-gateway/            # API 게이트웨이
├── auth-service/           # 인증 서비스
│   ├── src/
│   ├── tests/
│   ├── Dockerfile
│   └── package.json
├── order-service/          # 주문 서비스
│   ├── src/
│   ├── tests/
│   ├── Dockerfile
│   └── package.json
├── payment-service/        # 결제 서비스
├── notification-service/   # 알림 서비스
└── shared/                 # 공유 라이브러리
    ├── contracts/          # API 계약/이벤트 스키마
    └── utils/              # 공통 유틸
```

## 독립 사용 시
- `/microservice 설계` — 서비스 분리 설계 및 통신 방식 정의
- `/microservice 구현` — 개별 서비스 스캐폴딩 및 구현

## `/develop`과 조합 시
- Phase 1에서 서비스 경계 정의
- `--event-driven --cqrs`와 자주 조합

## 출력
- 모든 출력 **한국어**
- 서비스 아키텍처 다이어그램 (텍스트)
- 통신 흐름도
