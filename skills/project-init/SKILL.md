---
name: project-init
description: 새 프로젝트 초기화. git 저장소 생성(이전 /git-init 흡수), 템플릿 복사(HANDOFF, .gitattributes, .env.example, 등), GitHub 리포/Project 보드/라벨/이슈 생성, 브랜치 전략 적용(기본 github-flow). /plan 이전 단계.
---

# /project-init — 프로젝트 초기화

## 호출 형식
```
/project-init [--git-flow] [--github-flow] {프로젝트명}
```
기본: `--github-flow` (main + short-lived feature 브랜치). `--git-flow` 시 develop 포함.

## 파이프라인
1. **Git 초기화**
   - `git init` (없으면)
   - 기본 브랜치 `main` 확정
   - `--git-flow` 면 `develop` 추가 생성
2. **템플릿 복사** (`~/.claude/templates/` 에서)
   - `HANDOFF.md` → 루트 (프로젝트명 치환)
   - `CLAUDE.project.md` → `CLAUDE.md`
   - `.gitattributes`
   - `.env.example`
   - `scripts/env-check.js`
   - `.githooks/pre-commit` (+ `git config core.hooksPath .githooks`)
   - `.github/workflows/ci.yml`
3. **원격 리포 생성** (gh CLI)
   - `gh repo create {org}/{name} --private --source=. --remote=origin --push`
4. **GitHub Project 보드** (선택)
   - 칸반 보드 생성
   - 도메인 라벨 (`domain:auth`, `domain:order` 등)
   - Phase 0 이슈 (플래닝)
5. **첫 커밋**
   - `chore(init): 프로젝트 뼈대 (HANDOFF v2, CI, 템플릿)`
6. **원격 푸시**
7. `/plan` 제안

## 출력
```
## 프로젝트 초기화 완료
- 리포: {URL}
- 브랜치: main{, develop}
- HANDOFF: v2
- Project 보드: {URL 또는 없음}
- 다음: /plan {프로젝트}
```
