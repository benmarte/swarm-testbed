#!/usr/bin/env bash
set -euo pipefail

op="${1:-}"
a="${2:-}"
b="${3:-}"

case "$op" in
  add) echo $((a + b)) ;;
  sub) echo $((a - b)) ;;
  mul) echo $((a * b)) ;;
  *) printf 'usage: calc.sh <add|sub|mul> <a> <b>\n' >&2; exit 1 ;;
esac
