---
name: project-init
description: GitHub Project 초기화. 칸반 보드 생성, 도메인별 라벨 설정, 이슈 생성이 필요할 때 사용하세요.
---

# GitHub Project 초기화

GitHub Project 보드와 도메인별 라벨/이슈를 설정합니다.

## 입력
`$ARGUMENTS` — 도메인 목록 및 프로젝트 설명 (선택사항)

예시:
- `/project-init auth order payment` → auth, order, payment 도메인 라벨 생성
- `/project-init` → 코드 분석으로 도메인 자동 감지

## 계획서 연동 (`/start`에서 호출 시)
`/start`에서 호출되면 `docs/plans/{프로젝트명}-plan.md` 계획서가 이미 존재합니다.
이 경우:
- 계획서의 도메인 목록에서 라벨을 자동 생성
- 계획서의 작업 분해(이슈 형식)에서 이슈를 자동 생성
- 각 이슈에 계획서의 수용 기준, 세부 작업, 라벨 자동 적용
- 생성된 이슈 번호를 계획서에 역반영 (업데이트)

## 실행 단계

### 1. GitHub 리포지토리 확인
- `gh repo view`로 현재 리포지토리 확인
- 리모트 미설정 시 사용자에게 안내

### 2. GitHub Project (Board) 생성
```bash
# 칸반 보드 생성
gh project create --owner {owner} --title "{프로젝트명} 개발 보드"
```

칸반 컬럼:
- **백로그** — 아직 시작하지 않은 작업
- **진행중** — 현재 개발 중
- **리뷰중** — 코드 리뷰 대기
- **완료** — 완료된 작업

### 3. 라벨 생성

#### 도메인 라벨
`$ARGUMENTS`에 도메인이 지정되었으면 해당 도메인으로, 없으면 프로젝트 구조 분석하여 자동 감지.

```bash
# 도메인 라벨 (파란 계열 색상)
gh label create "domain:{도메인}" --color "{색상}" --description "{도메인} 도메인"
```

색상 로테이션: `0052CC`, `006B75`, `0E8A16`, `5319E7`, `D93F0B`, `FBCA04`

#### 유형 라벨
```bash
gh label create "type:feature" --color "0E8A16" --description "새 기능"
gh label create "type:bug" --color "D73A4A" --description "버그"
gh label create "type:refactor" --color "E99695" --description "리팩토링"
gh label create "type:docs" --color "0075CA" --description "문서"
gh label create "type:test" --color "FBCA04" --description "테스트"
gh label create "type:chore" --color "D4C5F9" --description "설정/빌드"
```

#### 우선순위 라벨
```bash
gh label create "priority:critical" --color "B60205" --description "즉시 처리"
gh label create "priority:high" --color "D93F0B" --description "높은 우선순위"
gh label create "priority:medium" --color "FBCA04" --description "중간 우선순위"
gh label create "priority:low" --color "0E8A16" --description "낮은 우선순위"
```

#### 상태 라벨
```bash
gh label create "status:blocked" --color "B60205" --description "차단됨"
gh label create "status:needs-review" --color "FBCA04" --description "리뷰 필요"
gh label create "status:in-progress" --color "0052CC" --description "진행중"
```

### 4. 이슈 생성 (선택사항)
`$ARGUMENTS`에 기능 목록이 포함되었으면 도메인별 이슈 자동 생성:

```bash
gh issue create \
  --title "[{도메인}] {기능 설명}" \
  --body "$(cat <<'EOF'
## 설명
{기능에 대한 설명}

## 수용 기준 (Acceptance Criteria)
- [ ] {기준 1}
- [ ] {기준 2}

## 작업 목록
- [ ] {세부 작업 1}
- [ ] {세부 작업 2}

## 관련 도메인
{도메인}
EOF
)" \
  --label "domain:{도메인},type:feature,priority:{우선순위}"
```

### 5. 이슈를 프로젝트 보드에 연결
```bash
# 생성된 이슈를 프로젝트에 추가
gh project item-add {프로젝트번호} --owner {owner} --url {이슈URL}
```

## 출력
```markdown
## 프로젝트 초기화 완료

### GitHub Project
- 보드: {프로젝트 URL}
- 컬럼: 백로그 | 진행중 | 리뷰중 | 완료

### 생성된 라벨
#### 도메인
{도메인 라벨 목록}

#### 유형/우선순위/상태
{라벨 목록}

### 생성된 이슈
{이슈 목록 및 번호}

### 다음 단계
- `/develop --tdd --ddd {기능}` 으로 개발 시작
- 이슈가 자동으로 브랜치/커밋과 연결됩니다
```

## 주의사항
- `gh` CLI가 인증되어 있어야 합니다 (`gh auth status`)
- 기존 라벨과 충돌 시 업데이트 (덮어쓰기 아님)
- 모든 출력 **한국어**
