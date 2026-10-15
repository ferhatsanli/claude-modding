#!/usr/bin/env bash
# Shared steps for setup-mac.sh, setup-linux.sh and setup-android.sh.
# Not meant to be run directly. Each platform script sets:
#   SOURCE_DIR  - the repo's agent folder
#   ROOT        - the modding root to create
#   SHELL_RC    - the shell startup file to add the environment variable to

COMPACT_PERCENT="${COMPACT_PERCENT:-65}"

copy_agent_setup() {
  echo "Modding root: $ROOT"
  mkdir -p "$ROOT/games"
  # Existing files are overwritten (updates); game folders are never touched.
  cp -f "$SOURCE_DIR/CLAUDE.md" "$ROOT/"
  cp -Rf "$SOURCE_DIR/.claude" "$ROOT/"
  cp -Rf "$SOURCE_DIR/templates" "$ROOT/"
  cp -f "$SOURCE_DIR/games/README.md" "$ROOT/games/"
}

set_compact_threshold() {
  # Auto-compact threshold must be an environment variable to work reliably.
  local line="export CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=$COMPACT_PERCENT"
  touch "$SHELL_RC"
  if grep -q "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE" "$SHELL_RC"; then
    sed -i.bak "s/^export CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=.*/$line/" "$SHELL_RC" && rm -f "$SHELL_RC.bak"
  else
    printf '\n# Claude Code: compact the context earlier\n%s\n' "$line" >> "$SHELL_RC"
  fi
  echo "Set CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=$COMPACT_PERCENT in $SHELL_RC"
}

install_claude_code() {
  if command -v claude >/dev/null 2>&1; then
    return
  fi
  echo "Installing Claude Code with the official installer..."
  if curl -fsSL https://claude.ai/install.sh | bash; then
    return
  fi
  # Fallback only if the official installer fails and npm is available.
  if command -v npm >/dev/null 2>&1; then
    echo "Official installer failed; trying npm..."
    npm install -g @anthropic-ai/claude-code
  else
    echo "Claude Code could not be installed. Run: curl -fsSL https://claude.ai/install.sh | bash"
  fi
}

install_um() {
  # The universal-modder CLI. Needs Python 3.10+ and uv (or pipx).
  if command -v um >/dev/null 2>&1; then
    return
  fi
  if command -v uv >/dev/null 2>&1; then
    uv tool install git+https://github.com/rehan-remade/universal-modder || true
  elif command -v pipx >/dev/null 2>&1; then
    pipx install git+https://github.com/rehan-remade/universal-modder || true
  else
    echo "Skipping um: neither uv nor pipx is available."
  fi
}

report_tools() {
  echo ""
  for t in git python3 uv ffmpeg node claude um; do
    if command -v "$t" >/dev/null 2>&1; then
      echo "[ok]      $t"
    else
      echo "[missing] $t"
    fi
  done
}

print_next_steps() {
  echo ""
  echo "Done. Open a new terminal (or run: source \"$SHELL_RC\"), then:"
  echo "  cd \"$ROOT\""
  echo "  claude"
  echo "Inside Claude Code, if the plugin is not installed yet:"
  echo "  /plugin marketplace add rehan-remade/universal-modder"
  echo "  /plugin install universal-modder@universal-modder"
}
