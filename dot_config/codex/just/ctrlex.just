# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
CTRLEX_CLI := "ctrlex"
preflight repo_root="." codex_home="" :
	$(CTRLEX_CLI) preflight --repo-root "{{repo_root}}" --codex-home "{{codex_home}}"

# {{contract}}: Path to the packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
enter_work contract repo_root="." codex_home="" :
	$(CTRLEX_CLI) enter-work --repo-root "{{repo_root}}" --codex-home "{{codex_home}}" "{{contract}}"

# {{contract}}: Path to the packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
run_packet contract repo_root="." codex_home="" :
	$(CTRLEX_CLI) run-packet --repo-root "{{repo_root}}" --codex-home "{{codex_home}}" "{{contract}}"

# {{contract}}: Path to the packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
collect_evidence contract repo_root="." codex_home="" :
	$(CTRLEX_CLI) collect-evidence --repo-root "{{repo_root}}" --codex-home "{{codex_home}}" "{{contract}}"

# {{repo_root}}: Absolute or relative path to the target repository root.
# {{codex_home}}: Override CODEX_HOME (defaults to environment or ~/.config/codex).
doctor repo_root="." codex_home="" :
	$(CTRLEX_CLI) doctor --repo-root "{{repo_root}}" --codex-home "{{codex_home}}"
