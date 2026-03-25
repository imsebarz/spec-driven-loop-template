#!/bin/bash
# Ralph Loop — lightweight spec-driven agent loop template

set -uo pipefail

AGENT="claude"
MODE=""
MAX_ITERATIONS=0
LOG_DIR=".ralph-logs"
mkdir -p "$LOG_DIR"

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
ITERATION=0

verify_agent() {
  case "$AGENT" in
    claude)
      command -v claude >/dev/null 2>&1 || {
        echo "Error: claude CLI not found"
        exit 1
      }
      ;;
    codex)
      command -v codex >/dev/null 2>&1 || {
        echo "Error: codex CLI not found"
        exit 1
      }
      ;;
    *)
      echo "Unsupported agent: $AGENT"
      exit 1
      ;;
  esac
}

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
  esac
}

sanitize_commit_message() {
  local message="$1"
  message="$(printf '%s\n' "$message" | tr -d '\r' | sed -n '/./{p;q;}')"
  message="$(printf '%s' "$message" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
  printf '%s' "$message"
}

fallback_commit_message() {
  printf 'chore(core): checkpoint interrupted loop work\n'
}

auto_checkpoint_if_dirty() {
  if git diff --quiet HEAD 2>/dev/null && git diff --cached --quiet HEAD 2>/dev/null; then
    return 0
  fi

  echo "⚠ Dirty worktree detected before next iteration"
  git add -A 2>/dev/null || true

  if git diff --cached --quiet HEAD 2>/dev/null; then
    return 0
  fi

  local changed_count
  changed_count=$(git diff --cached --name-only | wc -l | tr -d ' ')

  if [ "$changed_count" -le 3 ]; then
    local msg
    msg=$(fallback_commit_message)
    git commit -m "$(sanitize_commit_message "$msg")" 2>/dev/null || true
  else
    git stash push -m "ralph-interrupted-${AGENT}-${MODE}-$(date '+%H%M%S')" 2>/dev/null || true
  fi
}

verify_agent

echo "╔══════════════════════════════════════╗"
echo "║        ☕ Ralph Loop Started         ║"
echo "║       Spec-Driven Dev Template      ║"
echo "╚══════════════════════════════════════╝"
echo ""
echo "  Agent:  $AGENT"
echo "  Mode:   $MODE"
echo "  Prompt: $PROMPT_FILE"
[ "$MAX_ITERATIONS" -gt 0 ] && echo "  Max:    $MAX_ITERATIONS iterations"
echo ""

while true; do
  if [ "$MAX_ITERATIONS" -gt 0 ] && [ "$ITERATION" -ge "$MAX_ITERATIONS" ]; then
    break
  fi

  ITERATION=$((ITERATION + 1))
  auto_checkpoint_if_dirty

  LOG_FILE="$LOG_DIR/${AGENT}-${MODE}-${ITERATION}-$(date '+%Y%m%d-%H%M%S').log"

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "☕ Iteration #$ITERATION — $AGENT — $MODE"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  run_agent "$PROMPT_FILE" "$LOG_FILE" || true

  sleep 5
done

echo ""
echo "Ralph Loop finished. Logs: $LOG_DIR/"
