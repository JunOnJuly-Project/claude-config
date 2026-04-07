# 글로벌 개발 지침

## 세션 시작 규칙 (필수)

1. **전역 규칙 최신화**: `git -C ~/.claude pull --ff-only` (실패 시에만 사용자 보고)
2. **부트스트랩 게이트**: 현재 디렉터리가 프로젝트 저장소면 **첫 작업으로 `/bootstrap` 호출**. HANDOFF/브랜치/빌드/워크트리 정합성을 검증하고, 이상 발견 시 사용자에게 A/B/C 선택지 제시 후 작업 진행 여부 판단.
3. 블로킹 방지를 위해 1, 2 는 사용자 확인 없이 자동 수행. 게이트 실패 시에만 질문.

## 언어 정책

- 응답/주석/커밋 메시지/문서는 **한국어**
- 기술 용어(클래스명, 함수명, 라이브러리)는 영어 유지
- 사용자 대면 에러 메시지도 한국어

## 클린코드 컨벤션

### SOLID
SRP / OCP / LSP / ISP / DIP 준수.

### 코딩 규칙
- 함수 20줄 이내, 매개변수 3개 이내
- 네이밍: 함수=동사, 변수=명사, 불리언=is/has/can/should, 클래스=명사
- 매직넘버 금지, 설명적 상수명
- DRY: 3회 이상 반복 시 추출
- KISS: 가장 단순한 해결책 우선
- 주석: WHY만, WHAT은 코드가 설명

### 코드 리뷰 심각도 마커
`[치명적]` / `[중요]` / `[제안]` / `[칭찬]`

## 깃 컨벤션

### 자동 Git 초기화
모든 개발 작업 진입 시 `git rev-parse --is-inside-work-tree` 로 확인. 아니면 `/project-init` 으로 위임. 이미 저장소면 `/bootstrap` 으로.

### 기본 브랜치 전략: GitHub Flow
```
main                              # 항상 배포 가능
├── feature/{도메인}/{기능}       # 기능 개발 (short-lived)
├── bugfix/{도메인}/{설명}
└── hotfix/{설명}
```

Git Flow(develop 분리)는 `/project-init --git-flow` 로 **명시적** 선택 시에만 사용.

### 브랜치 네이밍
- `feature/{도메인}/{기능-kebab}`
- `bugfix/{도메인}/{이슈-설명}`
- `refactor/{도메인}/{설명}`
- `release/v{x}.{y}.{z}`
- `hotfix/{설명}`

### Conventional Commits (한국어)
```
{type}({도메인}): {한국어 설명}

{변경 이유 및 상세}

Refs #{이슈번호}
```
타입: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`

### 최소 구현 단위 커밋
하나의 커밋 = 하나의 논리적 변경. 순서: 인터페이스 → 테스트 → 구현 → 리팩터.

### 커밋-문서 동기화 (필수)
**모든 커밋은 연관 문서를 동시 업데이트해야 한다.** 코드만 커밋하고 문서를 미루는 것을 금지.

커밋 직전 체크리스트:
- [ ] `HANDOFF.md` — 진행 상태/완료 항목/다음 작업 갱신 (마일스톤/슬라이스 단위)
- [ ] `README.md` — 사용법·실행법·스택 변경 시
- [ ] `CHANGELOG.md` — 사용자 영향 있는 변경 (있다면)
- [ ] `docs/adr/` — 아키텍처/기술 결정 변경 시 새 ADR 또는 기존 ADR Superseded
- [ ] `docs/plans/` — 범위/일정/태스크 변경 시
- [ ] 코드 내 한국어 docstring/WHY 주석

문서 변경은 **같은 커밋**에 포함하거나, 코드 커밋 직후 **연속 docs 커밋**으로 처리한다(푸시 전). 슬라이스/마일스톤 종료 시 HANDOFF 갱신은 누락 불가.

## 도메인 엄격도 (L1-L3)

프로젝트는 `CLAUDE.md` (프로젝트 로컬) 에서 도메인별 레벨을 선언.

| 레벨 | 특성 |
|---|---|
| **L3** | Clean Arch + ArchUnit + 90% 커버리지. 단일 에이전트 금지, `/develop` 또는 `/team-develop` 필수 |
| **L2** | DDD 애그리거트 + 80% 커버리지 |
| **L1** | 프로토타입 허용 |

## 에이전트 팀 원칙

L2/L3 도메인의 모든 기능 개발은 **역할 분리된 에이전트 팀**으로 진행한다. 단일 에이전트가 처음부터 끝까지 작성 후 커밋하는 것을 금지.

- 기본 팀: planner / developer / tester / reviewer / documenter / debugger (`~/.claude/agents/`)
- 프로젝트별 특화 팀 확장 가능 (`.claude/agents/`)

## 테스트 커버리지 기준
- 단위: 핵심 로직 80%+ (L3 는 90%+)
- 통합: happy path 100%

## 문서화 기준
- 모든 모듈/클래스에 한국어 독스트링
- README, API 문서, ADR, CHANGELOG 한국어
- **HANDOFF.md 는 필수**: 다른 PC/세션에서 끊김 없이 이어받기 위한 표준 문서. `templates/HANDOFF.md` 스키마 v2 준수

## CLI 자동 허가 범위 (필수)

자동 허가된 Bash/CLI 명령은 **현재 프로젝트 루트(=세션 시작 시 cwd) 하위 경로에서만** 실행한다.

- ✅ 허용: `./`, `./src/...`, `./tests/...`, 프로젝트 루트 자체
- ❌ 금지 (자동 실행 금지, 사용자 명시 승인 필요):
  - 프로젝트 루트 밖 절대경로 (`C:\Windows\...`, `~/.ssh/...`, 다른 프로젝트)
  - `cd` 로 상위/타 디렉터리 이동 후 작업
  - `~/.claude/` 등 글로벌 설정 변경 (사용자가 명시 요청한 경우만 예외)
  - 시스템 패키지 설치 (`sudo`, 시스템 파이썬 글로벌 install 등)
- 예외: `git -C ~/.claude pull`(세션 시작 정합성), 사용자가 직접 지시한 글로벌 설정 변경

루트 밖 작업이 필요하면 **반드시 사용자에게 사유와 대상 경로를 먼저 보고하고 승인 받는다.**

## 작업 실행 원칙

### 자율 실행
- 긍정 응답 후에는 중간에 끊지 말고 연속 진행
- 방향이 명확하면 실행. 불확실하면 A/B/C 선택지 제시

### 재개 가능성 (필수)
- 모든 프로젝트는 다른 PC/세션에서 이어받을 수 있어야 한다
- 리포에 필수 포함: `README.md`(HANDOFF 링크), `HANDOFF.md`, `docs/plans/`, 빌드 래퍼, `.env.example`
- 마일스톤마다 `HANDOFF.md` 갱신 + 원격 푸시
- 새 세션은 반드시 `/bootstrap` 으로 시작

### 글로벌 설정 자동 푸시
`~/.claude/` 하위 변경 시 `chore(global): ...` 로 자동 커밋/푸시. 원격: `JunOnJuly-Project/claude-config`.

### 보고 간결성
Phase 종료 시에만 간단 요약 (커밋 해시, 이슈 번호, 다음 단계).

## 사용 가능한 Skills

| 명령어 | 역할 |
|---|---|
| `/bootstrap` | 세션 정합성 게이트 |
| `/handoff` | HANDOFF.md 관리 (init/update/validate/migrate) |
| `/project-init` | 새 프로젝트 초기화 (git + 템플릿 + GitHub) |
| `/plan` | 계획 + 브레인스토밍 3라운드 |
| `/develop` | 에이전트 팀 개발 파이프라인 |
| `/debug` | 체계적 디버깅 |
| `/review` | 코드 리뷰 |
| `/doc` | 문서 생성/갱신 |

### 방법론 플래그 (`/develop`, `/plan` 조합)
`--tdd`, `--ddd`, `--clean-arch`, `--hexagonal`, `--bdd`, `--event-driven`, `--cqrs`, `--fp`, `--microservice`

각 플래그는 `~/.claude/references/methodologies/{name}.md` 를 참조하여 파이프라인 단계를 보강한다.
