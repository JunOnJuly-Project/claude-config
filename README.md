# Claude Code 글로벌 워크플로우 시스템

프로젝트에 귀속되지 않는 전역 개발 워크플로우 시스템입니다. `~/.claude/`에 설치하면 모든 프로젝트에서 사용할 수 있습니다.

## 설치

```bash
# ~/.claude/에 클론
git clone https://github.com/JunOnJuly-Project/claude-config.git ~/.claude

# 또는 기존 ~/.claude/가 있으면 필요한 파일만 복사
```

> **주의**: `config.json`은 API 키가 포함되어 있으므로 `.gitignore`에 등록되어 있습니다. Claude Code가 첫 실행 시 자동 생성합니다.

## 핵심 개념

### 글로벌 지침 (`CLAUDE.md`)
항상 적용되는 기본 규칙:
- 한국어 출력/주석/커밋 메시지 (기술 용어는 영어 유지)
- 클린코드 (SOLID, DRY, KISS, 함수 20줄 이내, 매개변수 3개 이내)
- Git Flow + 도메인 단위 브랜치 + 최소 구현 단위 커밋
- 테스트 커버리지 기준 (단위 80%+, 통합 핵심경로 100%)
- 코드 리뷰 심각도 마커: `[치명적]` `[중요]` `[제안]` `[칭찬]`

### 에이전트 (`agents/`)

| 에이전트 | 모델 | 역할 |
|----------|------|------|
| planner | Opus | 아키텍처 설계, 작업 분해, 브레인스토밍 통합 |
| developer | Sonnet | 핵심 개발, 클린코드 구현 |
| reviewer | Opus | 코드 리뷰 (읽기전용, 심각도 마커) |
| tester | Sonnet | 테스트 생성, 커버리지 확인 |
| documenter | Sonnet | README, API 문서, ADR, CHANGELOG |
| debugger | Opus | 체계적 7단계 버그 분석 |

planner, developer, reviewer, tester는 브레인스토밍 모드(라운드 1~3)를 지원합니다.

## 워크플로우 스킬 (`skills/`)

| 명령어 | 설명 |
|--------|------|
| `/start` | **총괄 오케스트레이터** — 정보 수집 → 브레인스토밍 → git-init → project-init → develop |
| `/develop` | 전체 개발 사이클 (계획→문서→테스트→구현→리뷰→커밋) |
| `/plan` | 프로젝트 계획 및 작업 분해 |
| `/doc` | 문서 생성 (README, API, ADR, CHANGELOG) |
| `/review` | 클린코드 기반 코드 리뷰 |
| `/test` | 테스트 생성 및 실행 |
| `/git-init` | Git Flow 초기 설정 |
| `/project-init` | GitHub Project 보드 + 이슈 초기화 |
| `/debug` | 체계적 디버깅 |
| `/refactor` | 코드 리팩토링 |

## 방법론 스킬 (선택적, 조합 가능)

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

### 조합 규칙
- **상호보완** (권장): `--tdd + --ddd`, `--tdd + --clean-arch`, `--event-driven + --cqrs`
- **중복**: `--tdd + --bdd` → BDD 시나리오를 TDD Red 단계로 사용
- **독립**: `--fp + --tdd`, `--microservice + --event-driven`
- 모든 조합이 허용되며, 상충 시 두 방법론의 장점을 통합 적용

## `/start` 플로우

```
Phase -1: 정보 수집 (인터뷰)
├─ 사용자 입력 파싱 (방법론 플래그 + 프로젝트 설명)
├─ 정보 충분성 판단 (필수: 목적, 사용자, 핵심 기능)
├─ 기능 제안 (일반/추천/유니크 3카테고리)
├─ 애매한 답변 시 재질문 (최대 3회, 선택지 제시)
├─ 프로젝트 정의서 생성
└─ 사용자 승인

Phase 0: 브레인스토밍 (3라운드 델파이)
├─ 라운드 1: 4개 에이전트 병렬 관점 수집
│  ├─ Planner: 아키텍처 초안, 도메인 분석
│  ├─ Developer: 기술 스택 실현 가능성
│  ├─ Reviewer: 위험 요소, 보안 분석
│  └─ Tester: 테스팅 전략 수립
├─ 라운드 2: 교차 검토 및 상호 피드백
├─ 라운드 3: Planner 최종 통합 + 나머지 검증
└─ 사용자 승인 (승인/수정/거부)

Phase 1: Git 환경 설정 (Git Flow 브랜치 전략)
Phase 2: 프로젝트 초기화 (GitHub Project 보드 + 도메인별 이슈)
Phase 3: 도메인별 /develop 자동 실행
Phase 4: 최종 보고
```

## 사용법

```bash
# 새 프로젝트 시작 (전체 플로우: 인터뷰 → 브레인스토밍 → 개발)
/start --tdd --ddd 전자상거래 플랫폼

# 방법론 조합
/start --tdd --clean-arch REST API 서버

# 방법론 없이
/start 간단한 CLI 도구

# 개별 스킬 사용
/develop --tdd 로그인 기능
/review
/debug 에러 메시지
/test 유저 서비스
/ddd 프로젝트 분석
```

## 깃 컨벤션

### 브랜치 전략
```
main                              # 프로덕션
├── develop                       # 통합 개발
│   ├── feature/{도메인}/{기능}    # 기능 개발
│   ├── bugfix/{도메인}/{설명}     # 버그 수정
│   └── refactor/{도메인}/{설명}   # 리팩토링
├── release/v{x}.{y}.{z}         # 릴리스
└── hotfix/{설명}                  # 긴급 수정
```

### 커밋 형식
```
{type}({도메인}): {한국어 설명}

{변경 이유}

Refs #{이슈번호}
```

- 하나의 커밋 = 하나의 논리적 변경
- 커밋 순서: 인터페이스 정의 → 테스트 → 구현 → 리팩토링

### 이슈-브랜치-커밋 연결
```
이슈 #12: [auth] 로그인 기능
  ├─ 브랜치: feature/auth/login
  ├─ 커밋: feat(auth): 인터페이스 정의 (Refs #12)
  ├─ 커밋: test(auth): 테스트 추가 (Refs #12)
  ├─ 커밋: feat(auth): 구현 (Refs #12)
  └─ PR 머지 → Closes #12 → 이슈 자동 닫힘
```

## 설정 (`settings.json`)

- **Agent Teams**: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` 활성화
- **SessionStart 훅**: 한국어 모드 + 컨벤션 준수 프라이밍
- **PreToolUse 훅**: Write/Edit 시 클린코드 확인 리마인더
- **권한**: git, gh, npm, python, docker 등 일반 명령 사전 허용

## 다른 PC에서 사용

```bash
# 1. ~/.claude/에 클론
git clone https://github.com/JunOnJuly-Project/claude-config.git ~/.claude

# 2. Claude Code 실행 — config.json은 자동 생성됨
# 3. gh auth login — GitHub CLI 인증 (project-init 사용 시 필요)
```

## 파일 구조

```
~/.claude/
├── CLAUDE.md                    # 글로벌 지침
├── settings.json                # 훅, 권한, 환경변수
├── README.md                    # 이 파일
├── agents/
│   ├── planner.md               # 계획/설계 (Opus)
│   ├── developer.md             # 핵심 개발 (Sonnet)
│   ├── reviewer.md              # 코드 리뷰 (Opus, 읽기전용)
│   ├── tester.md                # 테스트 (Sonnet)
│   ├── documenter.md            # 문서화 (Sonnet)
│   └── debugger.md              # 디버깅 (Opus)
└── skills/
    ├── start/SKILL.md           # /start 오케스트레이터
    ├── develop/SKILL.md         # /develop 개발 워크플로우
    ├── plan/SKILL.md            # /plan 계획
    ├── doc/SKILL.md             # /doc 문서 생성
    ├── review/SKILL.md          # /review 코드 리뷰
    ├── test/SKILL.md            # /test 테스트
    ├── git-init/SKILL.md        # /git-init Git Flow
    ├── project-init/SKILL.md    # /project-init GitHub Project
    ├── debug/SKILL.md           # /debug 디버깅
    ├── refactor/SKILL.md        # /refactor 리팩토링
    ├── tdd/SKILL.md             # /tdd
    ├── ddd/SKILL.md             # /ddd
    ├── clean-arch/SKILL.md      # /clean-arch
    ├── hexagonal/SKILL.md       # /hexagonal
    ├── event-driven/SKILL.md    # /event-driven
    ├── cqrs/SKILL.md            # /cqrs
    ├── bdd/SKILL.md             # /bdd
    ├── fp/SKILL.md              # /fp
    └── microservice/SKILL.md    # /microservice
```
