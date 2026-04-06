# Claude Code 글로벌 워크플로우 설정

Claude Code의 전역 개발 워크플로우 시스템입니다. 프로젝트에 귀속되지 않고 모든 프로젝트에서 사용할 수 있습니다.

## 설치

```bash
# 이 레포를 ~/.claude/에 클론
git clone https://github.com/JunOnJuly-Project/claude-config.git ~/.claude

# 또는 기존 ~/.claude/가 있으면 필요한 파일만 복사
```

## 구성 요소

### 글로벌 지침 (`CLAUDE.md`)
- 한국어 출력/주석/커밋 메시지
- 클린코드 컨벤션 (SOLID, DRY, KISS)
- Git Flow + 도메인 단위 브랜치 + 최소 구현 단위 커밋
- 문서화 기준

### 에이전트 (`agents/`)
| 에이전트 | 모델 | 역할 |
|----------|------|------|
| planner | Opus | 아키텍처 설계, 작업 분해, 브레인스토밍 |
| developer | Sonnet | 핵심 개발, 클린코드 구현 |
| reviewer | Opus | 코드 리뷰 (읽기전용) |
| tester | Sonnet | 테스트 생성, 커버리지 확인 |
| documenter | Sonnet | README, API 문서, ADR, CHANGELOG |
| debugger | Opus | 체계적 버그 분석, 근본 원인 추적 |

### 워크플로우 스킬 (`skills/`)
| 명령어 | 설명 |
|--------|------|
| `/start` | 에이전트 팀 브레인스토밍 → 승인 → git-init → project-init → develop |
| `/develop` | 전체 개발 워크플로우 (계획→문서→TDD→구현→리뷰→커밋) |
| `/plan` | 프로젝트 계획 및 작업 분해 |
| `/doc` | 문서 생성 (README, API, ADR, CHANGELOG) |
| `/review` | 클린코드 기반 코드 리뷰 |
| `/test` | 테스트 생성 및 실행 |
| `/git-init` | Git Flow 초기 설정 |
| `/project-init` | GitHub Project 보드 + 이슈 초기화 |
| `/debug` | 체계적 디버깅 |
| `/refactor` | 코드 리팩토링 |

### 방법론 스킬 (선택적, 조합 가능)
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

## 사용법

```bash
# 새 프로젝트 시작 (에이전트 팀 브레인스토밍 포함)
/start --tdd --ddd 전자상거래 플랫폼

# 방법론 조합
/start --tdd --clean-arch REST API 서버

# 개별 스킬 사용
/develop --tdd 로그인 기능
/review
/debug 에러 메시지
/ddd 프로젝트 분석
```

## 주의사항
- `config.json`은 API 키가 포함되어 있으므로 `.gitignore`에 등록되어 있습니다
- 다른 PC에서 사용 시 이 레포를 `~/.claude/`에 클론하면 됩니다
- Claude Code가 `config.json`은 첫 실행 시 자동 생성합니다
