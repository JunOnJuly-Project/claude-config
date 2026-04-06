---
name: bootstrap
description: 세션 시작 시 프로젝트 정합성을 검증하는 게이트. HANDOFF.md 존재/스키마, 브랜치 정렬, 워크트리 일치, 빌드 상태, 환경변수, git clean 여부를 점검하고 이상 발견 시 사용자에게 선택지를 제시한다. 모든 개발 스킬(/develop, /debug, /plan) 이전에 자동 호출된다.
---

# /bootstrap — 세션 부트스트랩 게이트

## 목적
새 세션 또는 새 PC 에서 작업을 이어받을 때 "전제 조건이 무너진 상태"를 조기에 감지한다. 이전 세션의 MockStock 실패(워크트리 불일치로 Trading 코드 접근 불가)를 재발 방지.

## 실행 순서
1. **Git 저장소 확인**: `git rev-parse --is-inside-work-tree`. 아니면 사용자에게 `/project-init` 제안 후 중단.
2. **HANDOFF 존재 검증**: `HANDOFF.md` 없으면 `/handoff init` 제안.
3. **HANDOFF 스키마 검증**: `templates/handoff.schema.json` 과 대조 (필수 섹션: 개요/실행/진행상태/블로커/재개체크리스트).
4. **브랜치 정렬 확인**: HANDOFF 의 "현재 브랜치" 와 `git branch --show-current` 가 일치하는지. 불일치 시 선택지 제시.
5. **워크트리 일치**: `git worktree list` 에 HEAD 가 기록된 브랜치와 일치하는지. Claude 자동 워크트리(`claude/*`) 가 main 기반이면 경고.
6. **빌드 상태 표식**: `HANDOFF.md` 의 "🔴 블로커" 섹션 파싱. 있으면 내용 요약 + "먼저 해결하시겠습니까?" 질문.
7. **git clean 확인**: dirty 면 이전 세션 미완료 변경 가능성 경고.

## 출력 형식
```
## 부트스트랩 결과
- 저장소: OK
- HANDOFF: OK (v2)
- 브랜치: feature/trading/port-out-reconstruction ✓
- 워크트리: main tree (OK)
- 빌드 상태: 🔴 블로커 #2 존재
- git status: clean

## 권고
{다음 작업 제안}
```

## 실패 처리
어느 단계든 실패 시 **현재 작업을 중단**하고 사용자에게 A/B/C 선택지 제시. 자율 진행 금지.
