set shell := bash
set shell.set := -euo pipefail

# global helpers
resolve_codex_home() {
  if [ -n "$codex_home" ]; then
    printf '%s' "$codex_home"
    return
  fi
  if [ -n "$CODEX_HOME" ]; then
    printf '%s' "$CODEX_HOME"
    return
  fi
  if [ -n "$XDG_CONFIG_HOME" ]; then
    printf '%s' "$XDG_CONFIG_HOME/codex"
    return
  fi
  printf '%s' "$HOME/.config/codex"
}

resolve_ctrlex_root() {
  local resolved_codex_home
  resolved_codex_home="$(resolve_codex_home)"
  local candidate
  candidate="${CTRLEX_ROOT:-$resolved_codex_home/skills/vendor/ctrlex}"
  if [ ! -d "$candidate" ]; then
    printf 'ERROR: CTRLEX_ROOT not found at %s. Set CTRLEX_ROOT to your ctrlex checkout under $CODEX_HOME/skills/vendor/ctrlex.\n' "$candidate" >&2
    exit 1
  fi
  printf '%s' "$candidate"
}

resolve_state_root() {
  local resolved_codex_home
  resolved_codex_home="$(resolve_codex_home)"
  printf '%s' "$resolved_codex_home/ctrlex"
}

# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
preflight repo_root="." codex_home="" :
  state_root="$(resolve_state_root)"
  codex_home="$(resolve_codex_home)"
  ctrlex_root="$(resolve_ctrlex_root)"
  python3 "$ctrlex_root/tools/root_preflight.py" --repo-root "$repo_root" --codex-home "$codex_home"

# {{contract}}: Path to packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
enter_work contract repo_root="." codex_home="" :
  codex_home="$(resolve_codex_home)"
  ctrlex_root="$(resolve_ctrlex_root)"
  python3 "$ctrlex_root/tools/g0_enter_work.py" --repo-root "$repo_root" --codex-home "$codex_home" "$contract"

# {{contract}}: Path to packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
run_packet contract repo_root="." codex_home="" :
  codex_home="$(resolve_codex_home)"
  ctrlex_root="$(resolve_ctrlex_root)"
  python3 "$ctrlex_root/tools/run_packet.py" --repo-root "$repo_root" --codex-home "$codex_home" "$contract"

# {{contract}}: Path to packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
collect_evidence contract repo_root="." codex_home="" :
  codex_home="$(resolve_codex_home)"
  ctrlex_root="$(resolve_ctrlex_root)"
  python3 "$ctrlex_root/tools/evidence/collect_packet_evidence.py" --repo-root "$repo_root" --codex-home "$codex_home" "$contract"

# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
doctor repo_root="." codex_home="" :
  codex_home="$(resolve_codex_home)"
  ctrlex_root="$(resolve_ctrlex_root)"
  state_root="$(resolve_state_root)"
  printf 'repo_root=%s\n' "$(cd "$repo_root" && pwd -P)"
  printf 'CODEX_HOME=%s\n' "$codex_home"
  printf 'CTRLEX_ROOT=%s\n' "$ctrlex_root"
  printf 'state_root=%s (exists=%s)\n' "$state_root" "$(if [ -d "$state_root" ]; then printf yes; else printf no; fi)"
