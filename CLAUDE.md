# 글로벌 개발 지침

## 언어 정책

- 모든 응답, 주석, 커밋 메시지, 문서는 **한국어**로 작성
- 기술 용어(클래스명, 함수명, 라이브러리명)는 영어 유지
- 사용자 대면 에러 메시지는 한국어
- 예시: `// JWT 토큰의 만료 시간을 검증한다` (O), `// Verify JWT token expiry` (X)

## 클린코드 컨벤션

### SOLID 원칙
- **SRP**: 클래스/함수는 단일 책임만 가진다
- **OCP**: 확장에 열려있고, 수정에 닫혀있다
- **LSP**: 하위 타입은 상위 타입을 대체할 수 있다
- **ISP**: 사용하지 않는 인터페이스에 의존하지 않는다
- **DIP**: 구체가 아닌 추상에 의존한다

### 코딩 규칙
- **함수**: 20줄 이내, 단일 목적, 매개변수 3개 이내 (초과 시 객체/DTO 사용)
- **네이밍**: 함수는 동사(`calculateTotal`), 변수는 명사, 불리언은 `is/has/can/should` 접두사, 클래스는 명사
- **상수**: 매직넘버/문자열 금지, 설명적 상수명 사용
- **DRY**: 동일 패턴 3회 이상 반복 시 추출
- **KISS**: 가장 단순한 해결책 우선, 과도한 추상화 금지
- **주석**: WHY만 설명, WHAT은 코드가 설명

### 코드 리뷰 심각도 마커
- `[치명적]` — 즉시 수정 필요 (보안, 데이터 손실, 크래시)
- `[중요]` — 머지 전 수정 권장 (로직 오류, 성능 문제)
- `[제안]` — 개선 사항 (네이밍, 구조, 가독성)
- `[칭찬]` — 잘 작성된 코드 인정

## 깃 컨벤션

### 자동 Git 초기화 (필수)

모든 개발 작업 시작 전에 현재 작업 디렉토리의 git 상태를 확인한다.

- `git rev-parse --is-inside-work-tree` 로 git 저장소 여부 확인
- **저장소가 아니면 자동으로 `git init` → `main` 브랜치 생성 → `.gitignore` 작성 → develop 브랜치 생성** 후 작업을 진행한다
- 이미 저장소라면 `develop` 브랜치 존재 여부만 확인하고 없으면 생성한다
- 이 초기화는 사용자에게 별도 질문 없이 자동 수행한다 (블로킹 방지)
- `/start`, `/develop` 등 모든 개발 오케스트레이터 skill은 Phase 1 진입 직전 이 절차를 실행해야 한다
- git이 준비된 후에는 반드시 적절한 feature 브랜치로 체크아웃한 상태에서 코드를 작성한다

### 브랜치 전략 (Git Flow + 도메인 단위)
```
main                              # 프로덕션
├── develop                       # 통합 개발
│   ├── feature/{도메인}/{기능}    # 기능 개발
│   ├── bugfix/{도메인}/{설명}     # 버그 수정
│   └── refactor/{도메인}/{설명}   # 리팩토링
├── release/v{x}.{y}.{z}         # 릴리스
└── hotfix/{설명}                  # 긴급 수정
```

### 브랜치 네이밍
- `feature/{도메인}/{기능-kebab-case}` — 예: `feature/auth/jwt-login`
- `bugfix/{도메인}/{이슈번호-설명}` — 예: `bugfix/auth/42-token-expire`
- `refactor/{도메인}/{설명}` — 예: `refactor/order/extract-service`
- `release/v{major}.{minor}.{patch}` — 예: `release/v1.2.0`
- `hotfix/{설명}` — 예: `hotfix/critical-auth-bypass`

### Conventional Commits (한국어)
```
{type}({도메인}): {한국어 설명}

{변경 이유 및 상세 설명}

Refs #{이슈번호}
```

타입: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`

### 최소 구현 단위 커밋
- 하나의 커밋 = 하나의 논리적 변경
- 커밋 순서: 인터페이스 정의 → 테스트 → 구현 → 리팩토링 (각각 별도 커밋)
- 되돌리기 쉽도록 작고 원자적으로 유지
- 커밋 본문에 이슈 참조: `Refs #번호` 또는 `Closes #번호`

### GitHub 이슈-브랜치-커밋 연결
```
이슈 #12: [auth] 로그인 기능
  ├─ 브랜치: feature/auth/login
  ├─ 커밋: feat(auth): 인터페이스 정의 (Refs #12)
  ├─ 커밋: test(auth): 테스트 추가 (Refs #12)
  ├─ 커밋: feat(auth): 구현 (Refs #12)
  └─ PR 머지 → Closes #12 → 이슈 자동 닫힘
```

## 테스트 커버리지 기준

- **단위 테스트**: 핵심 비즈니스 로직 80% 이상
- **통합 테스트**: 핵심 경로(happy path) 100%
- 커버리지 도구가 설정되어 있으면 개발 완료 시 리포트 확인

## 문서화 기준

- 모든 모듈/클래스에 한국어 독스트링
- README.md: 프로젝트 설명, 설치, 사용법, 아키텍처 (한국어)
- API 문서: 엔드포인트, 파라미터, 응답 예시 (한국어)
- ADR (Architecture Decision Records): 날짜, 상태, 컨텍스트, 결정, 결과 (한국어)
- CHANGELOG: Keep a Changelog 형식 (한국어)

## 작업 실행 원칙 (사용자 협업 스타일)

사용자의 선호도에 맞춘 작업 진행 방식을 따른다.

### 자율 실행
- 사용자가 "승인", "진행", "해줘" 등 긍정 응답을 한 이후에는 **중간에 끊지 말고** 연속적으로 작업을 진행한다
- 불필요한 중간 확인 질문을 줄인다. 방향이 명확하면 그냥 실행한다
- Phase 중간에 과하게 요약/정리하지 말고, 자연스러운 마일스톤에서만 간결히 보고한다

### 중간 방향 전환 수용
- 사용자는 작업 중간에 방향을 바꿀 수 있다 ("잠깐, X로 바꿔줘")
- 이때는 즉시 현재 Phase 결과물을 업데이트하고 진행한다. 전체 재시작은 피한다
- 이미 생성한 산출물은 가능한 재활용한다

### 커밋/브랜치 자동화
- 도메인/이슈 단위 feature 브랜치는 자동으로 생성하고 체크아웃한다
- 논리적 단위마다 한국어 Conventional Commits 로 자동 커밋한다 (사용자가 명시적으로 금지한 경우 제외)
- 이슈 번호는 계획서의 이슈 번호를 자동으로 `Refs #n` 으로 연결한다

### 글로벌 설정 자동 푸시
- `~/.claude/` 하위 파일(CLAUDE.md, skills, agents, settings 등)이 변경되면 **자동으로 커밋하고 원격에 push** 한다
- 커밋 메시지 타입은 `chore(global)`, 본문은 변경 내역 요약
- 사용자 추가 확인 없이 즉시 푸시 (이 디렉토리는 `JunOnJuly-Project/claude-config` 리포로 동기화됨)

### 보고 간결성
- Phase 종료 시에만 간단 요약 (커밋 해시, 완료된 이슈 번호, 다음 단계)
- 긴 설명, 장황한 preamble 금지. 필요한 것만 말한다

## 사용 가능한 방법론 Skills

방법론은 강제가 아닌 선택 사항입니다. 필요 시 아래 Skills을 사용하세요:

| 명령어 | 방법론 |
|--------|--------|
| `/tdd` | Test-Driven Development |
| `/ddd` | Domain-Driven Design |
| `/clean-arch` | Clean Architecture |
| `/hexagonal` | Hexagonal Architecture |
| `/event-driven` | Event-Driven Architecture |
| `/cqrs` | CQRS |
| `/bdd` | Behavior-Driven Development |
| `/fp` | Functional Programming |
| `/microservice` | Microservice 패턴 |

`/develop` 사용 시 `--tdd --ddd` 플래그로 조합 가능.
