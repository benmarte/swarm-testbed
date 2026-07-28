#!/usr/bin/env bash
# local-develop.sh — swarm headless develop adapter driving the LOCAL model.
#
# Contract (swarm headless adapter): receive a prompt file as $1, edit the
# working tree, exit 0. The swarm engine owns all git/GitHub operations; this
# script must never touch git.
#
# Model: deepseek-v4-flash served at http://localhost:9000/v1 (llama.cpp, OpenAI-compatible)
# Harness: qwen-code CLI (non-interactive, auto-approve edits)
set -euo pipefail

prompt_file="${1:?usage: local-develop.sh <prompt-file>}"
[ -f "$prompt_file" ] || { printf 'local-develop: prompt file not found: %s\n' "$prompt_file" >&2; exit 1; }

export OPENAI_BASE_URL="${SWARM_LLM_BASE_URL:-http://localhost:9000/v1}"
export OPENAI_API_KEY="${SWARM_LLM_API_KEY:-local}"
export OPENAI_MODEL="${SWARM_LLM_MODEL:-deepseek-v4-flash}"

command -v qwen >/dev/null 2>&1 || {
  printf 'local-develop: qwen CLI not found on PATH (npm i -g @qwen-code/qwen-code)\n' >&2
  exit 1
}

printf 'local-develop: driving %s via qwen-code at %s\n' "$OPENAI_MODEL" "$OPENAI_BASE_URL"
qwen --yolo --bare -m "$OPENAI_MODEL" "$(cat "$prompt_file")"
printf 'local-develop: adapter complete\n'
