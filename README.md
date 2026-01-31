# Codex xtrl

xtrl is a repo-agnostic execution surface that lives under `$CODEX_HOME`. It
provides packet templates, execution tooling, and evidence conventions while
keeping all runtime state out of the target repositories.

## Export surface (skills-pack)
`skills-pack/` is the subtree-importable export surface for `$CODEX_HOME/skills/`:
- `skills-pack/xtrl.packet-runner/`
- `skills-pack/xtrl.packet-template/`

`skills/` remains as a compatibility layer (symlinks to `skills-pack/`).

## Global-only roots (no repo-local .codex/.quint)
xtrl must not create or depend on repo-local `./.codex/` or `./.quint/`.
All runtime artifacts live under the xtrl state root (the repo resolves to the
first existing directory in `$CODEX_HOME/{xtrl,ctrlex,plant-a}`):
```
$CODEX_HOME/xtrl/{packets,out,worktrees}/...
```
A compatibility alias may expose `$CODEX_HOME/ctrlex/` or `$CODEX_HOME/plant-a/`
if you are still migrating existing work.

## Install via chezmoi subtree (example)
From your chezmoi source directory:
```bash
git subtree add --prefix "$CODEX_HOME/skills/xtrl.packet-runner" /path/to/codex-plant-a skills-pack/xtrl.packet-runner --squash
git subtree add --prefix "$CODEX_HOME/skills/xtrl.packet-template" /path/to/codex-plant-a skills-pack/xtrl.packet-template --squash
```

## Run a packet (target-aware)
```bash
bash $CODEX_HOME/skills/xtrl.packet-runner/scripts/run_packet.sh \
  packets/examples/packet-000-foundation.json \
  --repo-root /path/to/target
```

## Evidence output
Evidence bundles are written under:
```
$CODEX_HOME/xtrl/out/<packet_id>/
```

## CLI & Just integration
The `xtrl` CLI aggregates the Python tooling so you can run the canonical
commands without walking into a repo:

```bash
xtrl preflight --repo-root /path/to/repo
xtrl run-packet --repo-root /path/to/repo packets/examples/<packet>.json
xtrl collect-evidence --repo-root /path/to/repo packets/examples/<packet>.json
```

Use `xtrl just render --out $CODEX_HOME/Justfile` to create the global Justfile
watched by `just-mcp`, and `xtrl just install-mcp` to print the MCP stanza that
runs `just-mcp --watch-dir "$CODEX_HOME:xtrl"`.

Install the bundled wrapper at `$CODEX_HOME/bin/xtrl` (see
`dot_config/codex/bin/xtrl`) so both the exported Justfile and the MCP server call
a stable executable path instead of depending on `PATH`. Start the just-mcp
server via `$CODEX_HOME/bin/xtrl-just-mcp`.
