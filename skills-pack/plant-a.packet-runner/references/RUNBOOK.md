# Packet Runner Runbook

## Scope
Local WORK runs are approval-free but contract-bounded; violations deny.
PROMOTE is the integration gate; local WORK still enforces contract invariants.

## G0 worktree default
If `worktrees/<packet_id>` exists under the Plant A state root, G0 will deny by default
(`deny_if_worktree_exists=true`).

Rerun options:
- Delete the worktree (e.g. `git worktree remove --force $CODEX_HOME/plant-a/worktrees/<packet_id>`).
- Or set `deny_if_worktree_exists=false` in the contract (intentional override).

## Minimal run
```bash
python $CODEX_HOME/plant-a/tools/run_packet.py packets/examples/<packet_id>.json --repo-root /path/to/target
```
