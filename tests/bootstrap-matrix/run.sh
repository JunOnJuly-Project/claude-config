#!/usr/bin/env bash
# bootstrap 분기 커버리지 러너.
# 각 case 의 setup.sh 로 fixture 저장소를 만든 뒤, assert.sh 의 한 줄 어서션을 실행하여
# expected.txt 와 diff. 모두 일치해야 통과.
set -uo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
WORK="${TMPDIR:-/tmp}/bootstrap-matrix-run"
rm -rf "$WORK"
mkdir -p "$WORK"

PASS=0
FAIL=0
FAILED_CASES=()

for case_dir in "$ROOT/cases"/case*/; do
  name="$(basename "$case_dir")"
  target="$WORK/$name"

  bash "$case_dir/setup.sh" "$target" >/dev/null 2>&1 || {
    echo "[FAIL] $name (setup error)"
    FAIL=$((FAIL+1)); FAILED_CASES+=("$name"); continue
  }

  actual="$(bash "$case_dir/assert.sh" "$target" 2>&1)"
  expected="$(cat "$case_dir/expected.txt")"

  if [ "$actual" = "$expected" ]; then
    echo "[PASS] $name"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $name"
    diff <(echo "$expected") <(echo "$actual") | sed 's/^/    /'
    FAIL=$((FAIL+1)); FAILED_CASES+=("$name")
  fi
done

echo
echo "결과: PASS=$PASS  FAIL=$FAIL"
[ $FAIL -eq 0 ] || { printf '실패: %s\n' "${FAILED_CASES[@]}"; exit 1; }
