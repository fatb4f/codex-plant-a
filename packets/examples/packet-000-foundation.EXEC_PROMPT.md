# EXEC_PROMPT

```json
{
  "schema_version": "1.0.0",
  "contract_path": "$CODEX_HOME/plant-a/packets/examples/packet-000-foundation.json",
  "worktree_root": "$CODEX_HOME/plant-a/worktrees/packet-000-foundation/",
  "tasks": [
    "Validate the packet runner end-to-end using this contract."
  ],
  "acceptance_checks": [
    "python $CODEX_HOME/plant-a/tools/run_packet.py packets/examples/packet-000-foundation.json --repo-root /path/to/target"
  ],
  "evidence": [
    "summary.md",
    "raw/diffstat.txt"
  ]
}
```

## Tasks
1) Validate the packet runner end-to-end using this contract.

## Acceptance checks
- `python $CODEX_HOME/plant-a/tools/run_packet.py packets/examples/packet-000-foundation.json --repo-root /path/to/target`

## Evidence
Required artifacts under `$CODEX_HOME/plant-a/out/packet-000-foundation/`:
- `summary.md`
- `raw/diffstat.txt`
