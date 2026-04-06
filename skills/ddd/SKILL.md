---
name: ddd
description: Domain-Driven Design 적용. 도메인 모델링, 바운디드 컨텍스트 설계, 도메인 레이어 분리가 필요할 때 사용하세요.
---

# Domain-Driven Design (DDD)

도메인 중심으로 소프트웨어를 설계하고 구현합니다.

## 입력
`$ARGUMENTS` — 분석/설계할 도메인 또는 기능 설명

## 전략적 설계 (Strategic Design)

### 1. 유비쿼터스 언어 (Ubiquitous Language)
- 도메인 전문가와 개발자가 공유하는 용어 정의
- 코드, 문서, 대화에서 동일한 용어 사용
- 용어 사전(Glossary) 작성

### 2. 바운디드 컨텍스트 (Bounded Context)
- 도메인을 독립적인 컨텍스트로 분리
- 각 컨텍스트의 경계와 책임 정의
- 컨텍스트 간 관계 매핑:
  - **공유 커널 (Shared Kernel)**: 공통 모델 공유
  - **고객-공급자 (Customer-Supplier)**: 상하 관계
  - **순응자 (Conformist)**: 외부 모델 수용
  - **부패 방지 레이어 (ACL)**: 외부 모델 변환

### 3. 컨텍스트 맵 (Context Map)
```
[인증 컨텍스트] ---ACL--- [사용자 컨텍스트]
       |                          |
   공유 커널                  고객-공급자
       |                          |
[권한 컨텍스트]            [주문 컨텍스트]
```

## 전술적 설계 (Tactical Design)

### 엔티티 (Entity)
- 고유 식별자(ID)를 가진 도메인 객체
- 생명주기 동안 동일성 유지
- 비즈니스 로직 포함

### 값 객체 (Value Object)
- 식별자 없이 속성 값으로만 동등성 판단
- 불변(Immutable)
- 예: Money, Address, Email

### 애그리거트 (Aggregate)
- 관련 엔티티와 VO의 군집
- 애그리거트 루트를 통해서만 접근
- 트랜잭션 일관성 경계

### 리포지토리 (Repository)
- 애그리거트의 영속성 관리
- 도메인 레이어에 인터페이스, 인프라에 구현
- 컬렉션처럼 동작

### 도메인 서비스 (Domain Service)
- 특정 엔티티에 속하지 않는 도메인 로직
- 상태를 가지지 않음(Stateless)

### 도메인 이벤트 (Domain Event)
- 도메인에서 발생한 중요한 사건
- 과거형 네이밍: `OrderPlaced`, `PaymentCompleted`
- 느슨한 결합 촉진

## 레이어 구조
```
├── domain/              # 도메인 레이어 (프레임워크 의존성 없음)
│   ├── entities/        # 엔티티
│   ├── value-objects/   # 값 객체
│   ├── aggregates/      # 애그리거트
│   ├── repositories/    # 리포지토리 인터페이스
│   ├── services/        # 도메인 서비스
│   └── events/          # 도메인 이벤트
├── application/         # 애플리케이션 레이어
│   ├── use-cases/       # 유스케이스
│   └── dto/             # 데이터 전송 객체
├── infrastructure/      # 인프라 레이어
│   ├── repositories/    # 리포지토리 구현
│   ├── persistence/     # DB 설정
│   └── external/        # 외부 서비스
└── presentation/        # 프레젠테이션 레이어
    ├── controllers/     # 컨트롤러
    └── middleware/       # 미들웨어
```

## 독립 사용 시
- `/ddd 프로젝트 분석` — 현재 코드의 도메인 모델 분석 및 개선 제안
- `/ddd 주문 도메인 설계` — 특정 도메인의 전략적/전술적 설계

## `/develop`과 조합 시
- Phase 1에서 바운디드 컨텍스트, 도메인 모델 설계
- Phase 4에서 도메인 레이어 분리 구현

## 출력
- 모든 출력 **한국어**
- 컨텍스트 맵, 도메인 모델 다이어그램 (텍스트)
- 유비쿼터스 언어 사전
