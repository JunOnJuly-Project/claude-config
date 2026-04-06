#!/usr/bin/env bash
cd "$1"
[ -f HANDOFF.md ] && echo "handoff" || echo "no-handoff"
