# Claude Code 글로벌 워크플로우 시스템

프로젝트에 귀속되지 않는 전역 개발 워크플로우. `~/.claude/` 에 설치하면 모든 프로젝트에서 사용.

## 설치

```bash
git clone https://github.com/JunOnJuly-Project/claude-config.git ~/.claude
```

> `config.json` 은 Claude Code 가 자동 생성 (gitignore).

## 설계 원칙

1. **재개 가능성** — 모든 프로젝트는 다른 PC/세션에서 끊김 없이 이어받을 수 있어야 한다. `HANDOFF.md` (스키마 v2) 필수
2. **부트스트랩 게이트** — 세션 시작 시 `/bootstrap` 으로 정합성 검증. 이상 발견 시 차단
3. **에이전트 팀 우선** — L2/L3 도메인은 단일 에이전트 작성 금지. 역할 분리된 팀으로만
4. **방법론은 참조, 스킬 아님** — TDD/DDD/Clean Arch 등 9개는 `references/methodologies/` 의 문서이며, `/develop --{플래그}` 로 호출

## 스킬 (`skills/`) — 9개

| 명령어 | 역할 |
|---|---|
| `/bootstrap` | 세션 정합성 게이트 (HANDOFF/브랜치/빌드/워크트리 검증) |
| `/handoff` | HANDOFF.md 관리 (init / update / validate / migrate) |
| `/project-init` | 새 프로젝트 초기화 (git init + 템플릿 복사 + GitHub 리포/Project) |
| `/plan` | 계획 + 브레인스토밍 3라운드 (planner/developer/tester/reviewer 델파이) |
| `/develop` | 에이전트 팀 개발 파이프라인 (11 단계) |
| `/debug` | 체계적 디버깅 (debugger → developer → tester → reviewer) |
| `/review` | 코드 리뷰 ([치명적]/[중요]/[제안]/[칭찬]) |
| `/doc` | 문서 생성 (README/API/ADR/CHANGELOG/HANDOFF) |

## 에이전트 (`agents/`) — 6개

| 에이전트 | 모델 | 역할 |
|---|---|---|
| planner | Opus | 아키텍처, 작업 분해, 브레인스토밍 |
| developer | Sonnet | 핵심 개발, 클린코드 구현 |
| tester | Sonnet | 테스트 생성, 커버리지 |
| reviewer | Opus | 코드 리뷰 (읽기 전용) |
| documenter | Sonnet | README/API/ADR/CHANGELOG |
| debugger | Opus | 7단계 근본 원인 분석 |

## 템플릿 (`templates/`)

프로젝트 초기화 시 복사되는 파일들:

- `HANDOFF.md` — 스키마 v2 (1~6 섹션 표준)
- `handoff.schema.json` — 스키마 검증용
- `CLAUDE.project.md` — 프로젝트 로컬 지침 (도메인 레벨 L1-L3)
- `.gitattributes` — LF 강제 (gradlew/Alpine 호환)
- `.env.example` — 환경변수 템플릿 (포트 18080 기본, Windows Hyper-V 회피)
- `scripts/env-check.js` — 크로스 플랫폼 환경 점검
- `.githooks/pre-commit` — 시크릿/빌드 산출물 커밋 차단
- `.github/workflows/ci.yml` — HANDOFF 검증 포함 CI

## 방법론 참조 (`references/methodologies/`)

스킬이 **아님**. `/develop --{플래그}` 로 호출.

| 플래그 | 파일 |
|---|---|
| `--tdd` | tdd.md |
| `--ddd` | ddd.md |
| `--clean-arch` | clean-arch.md |
| `--hexagonal` | hexagonal.md |
| `--bdd` | bdd.md |
| `--event-driven` | event-driven.md |
| `--cqrs` | cqrs.md |
| `--fp` | fp.md |
| `--microservice` | microservice.md |

조합 가능: `--tdd --clean-arch`, `--ddd --event-driven --cqrs` 등.

## 표준 워크플로우

### 새 프로젝트
```
/project-init 전자상거래
→ /plan --brainstorm 전자상거래 MVP
→ /develop --tdd --ddd order 주문 생성
```

### 기존 프로젝트 이어받기
```
# 새 PC
git clone {repo}
cd {repo}
claude
# 세션 시작 → /bootstrap 자동 호출 → HANDOFF 확인 → 다음 작업
```

### 일상 개발
```
/develop --tdd auth JWT 리프레시
/debug 로그인 500 에러
/review --strict
```

## 파일 구조

```
~/.claude/
├── CLAUDE.md                       # 글로벌 지침
├── settings.json                   # 훅, 권한, SessionStart 가 /bootstrap 호출
├── README.md                       # 이 파일
├── agents/                         # 6개 페르소나 에이전트
│   ├── planner.md
│   ├── developer.md
│   ├── tester.md
│   ├── reviewer.md
│   ├── documenter.md
│   └── debugger.md
├── skills/                         # 9개 워크플로우 스킬
│   ├── bootstrap/SKILL.md
│   ├── handoff/SKILL.md
│   ├── project-init/SKILL.md
│   ├── plan/SKILL.md
│   ├── develop/SKILL.md
│   ├── debug/SKILL.md
│   ├── review/SKILL.md
│   └── doc/SKILL.md
├── templates/                      # 프로젝트 초기화용 파일
│   ├── HANDOFF.md
│   ├── handoff.schema.json
│   ├── CLAUDE.project.md
│   ├── .gitattributes
│   ├── .env.example
│   ├── scripts/env-check.js
│   ├── .githooks/pre-commit
│   └── .github/workflows/ci.yml
├── tests/
│   └── bootstrap-matrix/           # /bootstrap 분기 회귀 테스트 (14 케이스)
│       ├── run.sh
│       ├── lib.sh
│       └── cases/case{1..14}-*/
└── references/
    └── methodologies/              # 9개 방법론 참조 문서
        ├── README.md
        ├── tdd.md
        ├── ddd.md
        ├── clean-arch.md
        ├── hexagonal.md
        ├── bdd.md
        ├── event-driven.md
        ├── cqrs.md
        ├── fp.md
        └── microservice.md
```

## 회귀 테스트 (`tests/`)

`/bootstrap` 9단계의 정상/이상 분기를 자기충족 fixture 로 검증.

```bash
bash ~/.claude/tests/bootstrap-matrix/run.sh
# 결과: PASS=14  FAIL=0
```

14개 케이스가 git/handoff/schema/branch/worktree/blocker/dirty/ignore 분기 전체를 커버.
세부 매핑은 `tests/bootstrap-matrix/README.md` 참조.

## 변경 이력 주요 사항

- **v2 (2026-04)**: 워크플로우 전면 재설계
  - 스킬 20개 → 9개 축소 (방법론 9개를 `references/` 로 이관, `start`/`test`/`refactor`/`git-init` 삭제)
  - `/bootstrap`, `/handoff` 신설 (정합성 게이트 + 핸드오프 관리)
  - `/develop` 을 실제 에이전트 팀 파이프라인으로 재작성
  - 기본 브랜치 전략 GitHub Flow 로 변경 (Git Flow 는 `--git-flow` 옵트인)
  - `templates/` 디렉터리 신설 (HANDOFF v2, CI, pre-commit, 환경 점검)
  - SessionStart hook 이 `/bootstrap` 자동 호출 지시
  - `/bootstrap` step9 신규: 신규 파일 ignore 사전 검사 (MockStock `out/` 사일런트 무시 사고 재발 방지)
  - `tests/bootstrap-matrix/` 14 케이스 회귀 매트릭스 신설

## 다른 PC 에서 사용

```bash
git clone https://github.com/JunOnJuly-Project/claude-config.git ~/.claude
gh auth login   # project-init 사용 시 필요
```
