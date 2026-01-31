# ctrlex MCP tools

This document explains how to expose ctrlex tooling via `just-mcp`.

## Install just-mcp
You can install via `binstall justmcp just-mcp` (preferred) or download a release tarball from https://github.com/justmcp/just-mcp/releases and unpack it into a directory on your `PATH`.

## Generate the watched Justfile
Run this once (or whenever the recipes change) so `just-mcp` can watch a stable, global Justfile:

```bash
ctrlex just render --out $CODEX_HOME/Justfile
```
The generated file exposes the migrated `preflight`, `enter_work`, `run_packet`, `collect_evidence`, and `doctor` recipes via the installed `ctrlex` CLI.

## Print the MCP config stanza
To register the MCP server, render a snippet that points at the global watch dir:

```bash
ctrlex just install-mcp
```
Copy the output into `~/.codex/config.toml` under `[mcp_servers.<name>]` so Codex can start the stdio server with `just-mcp`.

## Wrapper CLI
Install `$CODEX_HOME/bin/ctrlex` so the generated Justfile and MCP tools call a stable executable instead of relying on `PATH`. The wrapper ships in this repo under `dot_config/codex/bin/ctrlex` and simply proxies to the real ctrlex install (or your local checkout via `CTRLEX_ROOT`).

## Start the MCP server
```bash
$CODEX_HOME/bin/ctrlex-just-mcp
```
This watches `$CODEX_HOME` (named `ctrlex`) so the rendered `$CODEX_HOME/Justfile` is discovered and the recipes appear as MCP tools named `just_<recipe>@ctrlex` (for example, `just_preflight@ctrlex`).

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
