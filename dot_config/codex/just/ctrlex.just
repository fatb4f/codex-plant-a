# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
preflight repo_root="." codex_home="" :
	../bin/ctrlex-just-helper preflight "{{repo_root}}" "{{codex_home}}"

# {{contract}}: Path to packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
enter_work contract repo_root="." codex_home="" :
	../bin/ctrlex-just-helper enter_work "{{repo_root}}" "{{codex_home}}" "{{contract}}"

# {{contract}}: Path to packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
run_packet contract repo_root="." codex_home="" :
	../bin/ctrlex-just-helper run_packet "{{repo_root}}" "{{codex_home}}" "{{contract}}"

# {{contract}}: Path to packet contract JSON.
# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
collect_evidence contract repo_root="." codex_home="" :
	../bin/ctrlex-just-helper collect_evidence "{{repo_root}}" "{{codex_home}}" "{{contract}}"

# {{repo_root}}: Absolute or relative path to the target repo root (git repo).
# {{codex_home}}: Override CODEX_HOME base path (defaults to $CODEX_HOME/XDG_CONFIG_HOME or ~/.config/codex).
doctor repo_root="." codex_home="" :
	../bin/ctrlex-just-helper doctor "{{repo_root}}" "{{codex_home}}"
