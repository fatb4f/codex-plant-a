# Refactor Notes — Plant A (layout + target-aware runner)

## Old vs new skill layout
- Old: `skills/packet-runner` and `skills/packet-template`
- New: `skills-pack/plant-a.packet-runner` and `skills-pack/plant-a.packet-template`
- Compatibility: `skills/` is a symlink layer pointing at `skills-pack/`

## Subtree import surface
Import from `skills-pack/` into `$CODEX_HOME/skills/`:
- `skills-pack/plant-a.packet-runner` → `$CODEX_HOME/skills/plant-a.packet-runner`
- `skills-pack/plant-a.packet-template` → `$CODEX_HOME/skills/plant-a.packet-template`

## repo_root and CODEX_HOME resolution
- `repo_root`: `--repo-root PATH` wins; otherwise `git rev-parse --show-toplevel`.
- Clean check: `git -C "$repo_root" status --porcelain` must be empty.
- `CODEX_HOME`: `--codex-home PATH` wins; otherwise `$CODEX_HOME` or `$XDG_CONFIG_HOME/codex`.
- State root: `$CODEX_HOME/plant-a/{packets,out,worktrees}`.

## Smoke tests (minimal)
1) From inside a target repo:
   - `python $CODEX_HOME/plant-a/tools/run_packet.py packets/examples/packet-000-foundation.json`
2) From outside any repo:
   - `bash $CODEX_HOME/skills/plant-a.packet-runner/scripts/run_packet.sh packets/examples/packet-000-foundation.json --repo-root /path/to/target`
