#!/bin/bash
# Ralph Loop — lightweight spec-driven agent loop template

set -uo pipefail

AGENT="claude"
MODE=""
MAX_ITERATIONS=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)
      AGENT="$2"
      shift 2
      ;;
    plan)
      MODE="plan"
      shift
      ;;
    build)
      MODE="build"
      shift
      ;;
    [0-9]*)
      MAX_ITERATIONS="$1"
      shift
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Usage: ./ralph.sh [--agent claude|codex] [plan|build] [max_iterations]"
      exit 1
      ;;
  esac
done

[ -z "$MODE" ] && MODE="build"
PROMPT_FILE=$([ "$MODE" = "plan" ] && echo "PROMPT_plan.md" || echo "PROMPT_build.md")

run_agent() {
  local prompt_file="$1"
  local log_file="$2"

  case "$AGENT" in
    claude)
      claude -p --permission-mode bypassPermissions "$(cat "$prompt_file")" 2>&1 | tee "$log_file"
      ;;
    codex)
      codex exec --dangerously-bypass-approvals-and-sandbox -C "$(pwd)" - < "$prompt_file" 2>&1 | tee "$log_file"
      ;;
    *)
      echo "Unsupported agent: $AGENT"
      exit 1
      ;;
  esac
}

LOG_DIR=".ralph-logs"
mkdir -p "$LOG_DIR"
ITERATION=0

while true; do
  if [ "$MAX_ITERATIONS" -gt 0 ] && [ "$ITERATION" -ge "$MAX_ITERATIONS" ]; then
    break
  fi

  ITERATION=$((ITERATION + 1))
  LOG_FILE="$LOG_DIR/${AGENT}-${MODE}-${ITERATION}-$(date '+%Y%m%d-%H%M%S').log"

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "☕ Iteration #$ITERATION — $AGENT — $MODE"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  run_agent "$PROMPT_FILE" "$LOG_FILE" || true

  sleep 5
done

echo "Ralph Loop finished. Logs: $LOG_DIR/"
