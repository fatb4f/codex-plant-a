# ctrlex MCP tools

This document explains how to expose ctrlex tooling via `just-mcp`.

## Install just-mcp
You can install via `binstall justmcp just-mcp` (preferred) or download a release tarball from https://github.com/justmcp/just-mcp/releases and unpack it into a directory on your `PATH`.

## Start the MCP server
```bash
$CODEX_HOME/bin/ctrlex-just-mcp
```
This watches `$CODEX_HOME/ctrlex` and exposes the ctrlex recipes as MCP tools named `just_<recipe>@ctrlex` (for example, `just_preflight@ctrlex`).

## Refresh available tools
`just-mcp` exposes an `admin_sync` tool that forces a reload. Run:
```bash
just-mcp admin_sync
```

## Smoke checks
1. Run the doctor recipe without MCP to verify the environment:
   ```bash
   just -f $CODEX_HOME/ctrlex/Justfile doctor repo_root=/path/to/repo
   ```
2. Ensure the preflight recipe works:
   ```bash
   just -f $CODEX_HOME/ctrlex/Justfile preflight repo_root=/path/to/repo
   ```
3. Confirm the MCP tool listing includes the ctrlex recipes:
   ```bash
   just-mcp --watch-dir "$CODEX_HOME/ctrlex:ctrlex" --list-tools
   ```
   Look for entries such as `just_preflight@ctrlex`, `just_run_packet@ctrlex`, etc.

All recipes operate on the target repo via `--repo-root` and write state only under `$CODEX_HOME/ctrlex/{packets,out,worktrees}`.
