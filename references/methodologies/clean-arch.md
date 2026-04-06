# Clean Architecture

## 계층
```
domain/          — 순수 언어 (프레임워크 금지)
application/
  port/in/       — 유스케이스 인터페이스, Command DTO
  port/out/      — 저장소/외부 포트
  service/       — 유스케이스 구현 (Spring 의존 금지)
infrastructure/  — JPA/Redis/HTTP 어댑터
presentation/    — REST/GraphQL 컨트롤러
```

## 의존성 규칙
안쪽은 바깥쪽을 모른다. domain → application → infrastructure/presentation.

## 강제
ArchUnit 테스트로 `domain`/`application` 내 `org.springframework.*`, `jakarta.persistence.*` import 를 CI 에서 차단.

## /develop 통합
`--clean-arch` 플래그 시 planner 가 위 디렉터리 구조를 먼저 생성하고, reviewer 가 의존성 방향을 검증한다.
