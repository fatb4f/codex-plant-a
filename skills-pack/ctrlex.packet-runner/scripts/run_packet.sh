#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF' >&2
Usage: run_packet.sh <contract_path> [--repo-root PATH] [--codex-home PATH] [--resume]
EOF
}

CONTRACT_PATH=""
REPO_ROOT=""
CODEX_HOME_FLAG=""
RESUME=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo-root)
      REPO_ROOT="${2:-}"
      shift 2
      ;;
    --codex-home)
      CODEX_HOME_FLAG="${2:-}"
      shift 2
      ;;
    --resume)
      RESUME="--resume"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      exit 2
      ;;
    *)
      if [[ -z "$CONTRACT_PATH" ]]; then
        CONTRACT_PATH="$1"
        shift
      else
        echo "Unexpected argument: $1" >&2
        usage
        exit 2
      fi
      ;;
  esac
done

if [[ -z "$CONTRACT_PATH" ]]; then
  usage
  exit 2
fi

if [[ -z "$REPO_ROOT" ]]; then
  if ! REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"; then
    echo "must run inside a git repo or pass --repo-root" >&2
    exit 2
  fi
fi

if ! REPO_ROOT="$(git -C "$REPO_ROOT" rev-parse --show-toplevel 2>/dev/null)"; then
  echo "not a git repository: $REPO_ROOT" >&2
  exit 2
fi

if [[ -n "$(git -C "$REPO_ROOT" status --porcelain)" ]]; then
  echo "target repo not clean: $REPO_ROOT" >&2
  exit 2
fi

if [[ -n "$CODEX_HOME_FLAG" ]]; then
  CODEX_HOME="$CODEX_HOME_FLAG"
else
  if [[ -n "${CODEX_HOME:-}" ]]; then
    CODEX_HOME="${CODEX_HOME}"
  elif [[ -n "${XDG_CONFIG_HOME:-}" ]]; then
    CODEX_HOME="${XDG_CONFIG_HOME}/codex"
  else
    CODEX_HOME="${HOME}/.config/codex"
  fi
fi

CTRLEX_ROOT="${CODEX_HOME}/ctrlex"
RUNNER="${CTRLEX_ROOT}/tools/run_packet.py"

python "${RUNNER}" "${CONTRACT_PATH}" --repo-root "${REPO_ROOT}" --codex-home "${CODEX_HOME}" ${RESUME}
