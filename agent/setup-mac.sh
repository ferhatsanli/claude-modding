#!/usr/bin/env bash
# Sets up the modding root for Claude Code on macOS.
# Usage (from the repo's agent folder):
#   bash setup-mac.sh                          # root: ~/Modding
#   bash setup-mac.sh ~/Desktop/Modding        # custom root
#   INSTALL_TOOLS=1 bash setup-mac.sh          # also install tools with Homebrew

set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="${1:-$HOME/Modding}"
SHELL_RC="$HOME/.zshrc"

# shellcheck source=setup-common.sh
. "$SOURCE_DIR/setup-common.sh"

if [ "${INSTALL_TOOLS:-0}" = "1" ]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required for INSTALL_TOOLS=1. Install it from https://brew.sh first."
    exit 1
  fi
  echo "Installing tools with Homebrew..."
  brew install git python uv ffmpeg node
  install_claude_code
fi

copy_agent_setup
set_compact_threshold
install_um
report_tools
print_next_steps
