# Codex Plant A

Plant A is a repo-agnostic execution surface intended to live under `CODEX_HOME`.
It provides packet templates, execution tooling, and evidence conventions while keeping
all runtime state out of target repos.

## Export surface (skills-pack)
`skills-pack/` is the subtree-importable export surface for `$CODEX_HOME/skills/`:
- `skills-pack/plant-a.packet-runner/`
- `skills-pack/plant-a.packet-template/`

`skills/` remains as a compatibility layer (symlinks to `skills-pack/`).

## Global-only roots (no repo-local .codex/.quint)
Plant A must not create or depend on repo-local `./.codex/` or `./.quint/`.
All runtime artifacts live under the Plant A state root:
```
$CODEX_HOME/plant-a/{packets,out,worktrees}/...
```

## Install via chezmoi subtree (example)
From your chezmoi source directory:
```bash
git subtree add --prefix "$CODEX_HOME/skills/plant-a.packet-runner" /path/to/codex-plant-a skills-pack/plant-a.packet-runner --squash
git subtree add --prefix "$CODEX_HOME/skills/plant-a.packet-template" /path/to/codex-plant-a skills-pack/plant-a.packet-template --squash
```

## Run a packet (target-aware)
```bash
bash $CODEX_HOME/skills/plant-a.packet-runner/scripts/run_packet.sh \
  packets/examples/packet-000-foundation.json \
  --repo-root /path/to/target
```

## Evidence output
Evidence bundles are written under:
```
$CODEX_HOME/plant-a/out/<packet_id>/
```
