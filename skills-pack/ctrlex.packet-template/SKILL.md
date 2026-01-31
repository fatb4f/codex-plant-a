---
name: ctrlex.packet-template
description: Scaffold a packet contract and EXEC_PROMPT under the ctrlex state root.
---

## Purpose
Scaffold a new packet contract and EXEC_PROMPT from the SSOT templates:
- Directory layout (default): `packets/<area>/<packet_id>/contract.json` + `EXEC_PROMPT.md`
- Legacy flat layout: `packets/examples/<packet_id>.json` + `<packet_id>.EXEC_PROMPT.md`

## Entrypoints
- `scripts/new_packet.py`

## Inputs
- `packet_id` (required)
- Optional overrides: `area`, `repo`, `base_ref`, `branch`
- Optional: `layout` (dir|flat), `examples`, `validate_prompt`, `--codex-home`

## Outputs
- `packets/<area>/<packet_id>/contract.json`
- `packets/<area>/<packet_id>/EXEC_PROMPT.md`

## Notes
This skill only scaffolds the contract and prompt.
Use `ctrlex.packet-runner` to execute a packet.
