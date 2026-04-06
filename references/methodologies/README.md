# 방법론 참조 문서

`/develop --{방법론}` 플래그로 호출되는 방법론들. 스킬이 아니라 **참조 문서**다. `/develop` 이 해당 플래그를 받으면 이 문서를 읽어 파이프라인을 조정한다.

| 플래그 | 파일 | 요약 |
|---|---|---|
| `--tdd` | tdd.md | Red → Green → Refactor. 실패 테스트 선행 |
| `--ddd` | ddd.md | 바운디드 컨텍스트, 애그리거트, 유비쿼터스 언어 |
| `--clean-arch` | clean-arch.md | 계층 의존성 역전, ArchUnit 으로 강제 |
| `--hexagonal` | hexagonal.md | 포트/어댑터. in/out 양측 명시 |
| `--bdd` | bdd.md | Given-When-Then 시나리오 우선 |
| `--event-driven` | event-driven.md | 이벤트 버스, 발행-구독, 비동기 |
| `--cqrs` | cqrs.md | Command/Query 분리, 읽기/쓰기 모델 분리 |
| `--fp` | fp.md | 순수 함수, 불변성, 고차함수 |
| `--microservice` | microservice.md | 서비스 경계, 독립 배포, API 게이트웨이 |

## 조합 규칙
- 상호보완: `--tdd + --ddd`, `--tdd + --clean-arch`, `--event-driven + --cqrs`
- 중복: `--tdd + --bdd` → BDD 시나리오를 TDD Red 로 사용
- 독립: `--fp + --tdd`, `--microservice + --event-driven`
