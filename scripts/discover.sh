#!/bin/bash
# Discovery loop — interview the user and convert answers into specs

set -euo pipefail

AGENT="claude"
MODE="interactive"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)
      AGENT="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Usage: ./scripts/discover.sh [--agent claude|codex]"
      exit 1
      ;;
  esac
done

PROMPT_FILE="PROMPT_discovery.md"

if [ ! -f "$PROMPT_FILE" ]; then
  echo "Error: $PROMPT_FILE not found"
  exit 1
fi

INITIAL_PROMPT="$(cat "$PROMPT_FILE")"

case "$AGENT" in
  claude)
    command -v claude >/dev/null 2>&1 || { echo "Error: claude CLI not found"; exit 1; }
    exec claude "$INITIAL_PROMPT"
    ;;
  codex)
    command -v codex >/dev/null 2>&1 || { echo "Error: codex CLI not found"; exit 1; }
    exec codex "$INITIAL_PROMPT"
    ;;
  *)
    echo "Unsupported agent: $AGENT"
    exit 1
    ;;
esac
