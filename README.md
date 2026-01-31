# Codex ctrlex

ctrlex is a repo-agnostic execution surface intended to live under `CODEX_HOME`.
It provides packet templates, execution tooling, and evidence conventions while keeping
all runtime state out of target repos.

## Export surface (skills-pack)
`skills-pack/` is the subtree-importable export surface for `$CODEX_HOME/skills/`:
- `skills-pack/ctrlex.packet-runner/`
- `skills-pack/ctrlex.packet-template/`

`skills/` remains as a compatibility layer (symlinks to `skills-pack/`).

## Global-only roots (no repo-local .codex/.quint)
ctrlex must not create or depend on repo-local `./.codex/` or `./.quint/`.
All runtime artifacts live under the ctrlex state root:
```
$CODEX_HOME/ctrlex/{packets,out,worktrees}/...
```

## Install via chezmoi subtree (example)
From your chezmoi source directory:
```bash
git subtree add --prefix "$CODEX_HOME/skills/ctrlex.packet-runner" /path/to/codex-plant-a skills-pack/ctrlex.packet-runner --squash
git subtree add --prefix "$CODEX_HOME/skills/ctrlex.packet-template" /path/to/codex-plant-a skills-pack/ctrlex.packet-template --squash
```

## Run a packet (target-aware)
```bash
bash $CODEX_HOME/skills/ctrlex.packet-runner/scripts/run_packet.sh \
  packets/examples/packet-000-foundation.json \
  --repo-root /path/to/target
```

## Evidence output
Evidence bundles are written under:
```
$CODEX_HOME/ctrlex/out/<packet_id>/
```

## CLI & Just integration
The `ctrlex` CLI bundles the Python tooling so you can run the canonical commands without walking into a repo:

```bash
ctrlex preflight --repo-root /path/to/repo
ctrlex run-packet --repo-root /path/to/repo packets/examples/<packet>.json
ctrlex collect-evidence --repo-root /path/to/repo packets/examples/<packet>.json
```

Use `ctrlex just render --out $CODEX_HOME/Justfile` to create the global Justfile watched by `just-mcp`, and `ctrlex just install-mcp` to print the MCP stanza that runs `just-mcp --watch-dir "$CODEX_HOME/ctrlex:ctrlex"`.
