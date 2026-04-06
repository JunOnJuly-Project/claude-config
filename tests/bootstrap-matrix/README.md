# bootstrap-matrix

`/bootstrap` 스킬의 9개 단계 모든 분기를 검증하는 회귀 매트릭스.
각 케이스는 자기충족 fixture 저장소를 셋업한 뒤 한 줄 어서션을 실행하여
`expected.txt` 와 비교한다.

## 실행

```bash
bash tests/bootstrap-matrix/run.sh
```

성공 시 `결과: PASS=11  FAIL=0`. 실패 시 diff 출력 후 비0 종료.

## 분기 매핑

| # | 케이스 | 단계 | 분기 |
|---|---|---|---|
| 1 | case1-no-git | step1 | git 저장소 아님 |
| 2 | case2-no-handoff | step2 | HANDOFF.md 없음 |
| 3 | case3-schema-v1 | step3 | 구버전 v1 스키마 |
| 4 | case4-dirty-stale | step8 | dirty + stale untracked |
| 5 | case5-blocker-branch-mismatch | step4+step7 | 브랜치 불일치 + 단일 블로커 |
| 6 | case6-ignore-out | step9a | `out/` 비앵커 패턴이 도메인 소스 사일런트 무시 (MockStock 사고 재현) |
| 7 | case7-heuristic-bin | step9b | `bin/` 휴리스틱 경고 |
| 8 | case8-ignore-clean | step9c | 정상 통과 (false positive 방지) |
| 9 | case9-claude-worktree-main | step5 | claude/* 워크트리가 main HEAD 와 동일 |
| 10 | case10-orphan-worktree-dir | step6 | `.claude/worktrees/` 디렉터리만 잔재 |
| 11 | case11-multi-blocker | step7 | 다중 블로커 (🔴 3건) |

## 케이스 추가 방법

1. `cases/caseN-라벨/setup.sh` — fixture 저장소 생성. `lib.sh` 의 헬퍼(`handoff_v2`, `git_init_main`, `commit_all`) 활용
2. `cases/caseN-라벨/assert.sh` — 검증할 한 줄 출력 (stdout)
3. `cases/caseN-라벨/expected.txt` — 기대 stdout
4. `bash run.sh` 로 통과 확인

## 한계
- bootstrap 스킬을 LLM 이 직접 실행하는 게 아니라, 각 단계의 **검출 로직만** 재현
- 단일 분기 검증 위주. 다중 단계 동시 발화 조합은 case5 만 다룸
