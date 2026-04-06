#!/usr/bin/env bash
cd "$1"
grep -q "^> 스키마 버전: v2" HANDOFF.md && echo "v2" || echo "v1"
