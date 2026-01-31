set shell := ["bash","-e","-u","-o","pipefail"]

# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
preflight repo_root="." codex_home="" :
\tctrlex preflight --repo-root "{{repo_root}}" --codex-home "{{codex_home}}"

# {{contract}}: Path to the packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
enter_work repo_root="." codex_home="" contract:
\tctrlex enter-work --repo-root "{{repo_root}}" --codex-home "{{codex_home}}" "{{contract}}"

# {{contract}}: Path to the packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
run_packet repo_root="." codex_home="" contract:
\tctrlex run-packet --repo-root "{{repo_root}}" --codex-home "{{codex_home}}" "{{contract}}"

# {{contract}}: Path to the packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
collect_evidence repo_root="." codex_home="" contract:
\tctrlex collect-evidence --repo-root "{{repo_root}}" --codex-home "{{codex_home}}" "{{contract}}"

# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
doctor repo_root="." codex_home="" :
\tctrlex doctor --repo-root "{{repo_root}}" --codex-home "{{codex_home}}"
