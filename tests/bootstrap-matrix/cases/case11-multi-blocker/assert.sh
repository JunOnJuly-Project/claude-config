#!/usr/bin/env bash
cd "$1"
echo "blockers=$(grep -c '^🔴' HANDOFF.md)"
