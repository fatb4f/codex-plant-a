# Agents Runbook (ctrlex)

This file defines the instruction set for operating Codex ctrlex when installed
under the global Codex root (`CODEX_HOME`).

## Situational awareness
- **Global install:** ctrlex is installed under `$CODEX_HOME/ctrlex/` (Plant A is an alias for transition).
- **Target-aware:** All execution operates on an explicit target repo.
- **No repo-local roots:** ctrlex must not create or depend on `./.codex/` or `./.quint/`.

## Directory structure (global)
- `$CODEX_HOME/ctrlex/README.md` - repository purpose and entry points
- `$CODEX_HOME/ctrlex/plant.manifest.json` - structural manifest for drift prevention
- `$CODEX_HOME/ctrlex/schemas/` - JSON schemas for contracts and the manifest
- `$CODEX_HOME/ctrlex/packets/` - packet templates and example packets
- `$CODEX_HOME/ctrlex/tools/` - execution tools (preflight, worktree, evidence)
- `$CODEX_HOME/ctrlex/out/<packet_id>/` - evidence bundles
- `$CODEX_HOME/ctrlex/worktrees/<packet_id>/` - isolated worktrees (WORK zone)
- `$CODEX_HOME/skills/ctrlex.packet-template/` - packet scaffolding skill
- `$CODEX_HOME/skills/ctrlex.packet-runner/` - packet runner skill

## Packet contract template
Use the canonical template files:
- `packets/packet_contract.template.json`
- `packets/packet_contract.template.md`

The contract is the single source of truth for boundaries and execution policy.
Copy the JSON template to a packet file and fill identity, boundaries, worktree
policy, network policy, execution, budgets, and evidence settings.

## Packet EXEC_PROMPT
Each packet must include an `EXEC_PROMPT.md` that defines the execution contract.
The prompt should include:
- The authoritative contract path.
- The execution location: `worktrees/<packet_id>/`.
- The exact task list.
- Acceptance checks (tests, linters, or commands).
- Required evidence artifacts under `out/<packet_id>/`.

Template: `packets/EXEC_PROMPT.template.md`
Schema: `schemas/exec_prompt.schema.json` (metadata block at top of the prompt)

Recommended packet layout (directory form):
- `packets/<area>/<packet_id>/contract.json`
- `packets/<area>/<packet_id>/EXEC_PROMPT.md`

Legacy flat packets are deprecated and should be avoided for new work.
They may still exist under `packets/examples/<packet_id>.json`.
If using a flat contract, store the corresponding prompt as:
- `packets/examples/<packet_id>.EXEC_PROMPT.md`

## Transition alias notes
- A compatibility alias may expose `$CODEX_HOME/plant-a/` as a symlink to `$CODEX_HOME/ctrlex/` during the transition window.
- CLI consumers can keep using `plant-a` for now if an alias script forwards to `ctrlex`.

## Execution DAG (packet crafting)
See `packets/EXECUTION_DAG.md` for the end-to-end DAG that covers packet
crafting, worktree entry, execution, evidence, and promotion.

## Tooling structure
- `tools/root_preflight.py` - S0 root preflight guardrails.
- `tools/g0_enter_work.py` - G0 worktree provisioning and checks.
- `tools/run_packet.py` - primary packet runner orchestration.
- `tools/evidence/collect_packet_evidence.py` - evidence collection.
- `tools/validate_plant.py` - plant manifest validation for drift prevention.
- `tools/validate_exec_prompt.py` - validate EXEC_PROMPT metadata blocks.
- `tools/migrate_flat_packets.py` - migrate flat packets to directory layout (dry-run by default).
