#!/data/data/com.termux/files/usr/bin/bash
# Sets up the modding root for Claude Code on Android, inside Termux.
# Termux has its own package manager (pkg) and repositories, no sudo, and its own
# file system under $PREFIX, so it gets its own script.
# Usage (from the repo's agent folder, inside Termux):
#   bash setup-android.sh                      # root: ~/Modding (inside Termux)
#   bash setup-android.sh ~/storage/shared/Modding   # on phone storage (run termux-setup-storage first)
#   INSTALL_TOOLS=1 bash setup-android.sh      # also install tools with pkg

set -euo pipefail

if [ -z "${PREFIX:-}" ] || [ ! -d "$PREFIX" ]; then
  echo "This script is for Termux. On a normal Linux system use setup-linux.sh."
  exit 1
fi

SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="${1:-$HOME/Modding}"
SHELL_RC="$HOME/.bashrc"
# The native installer does not support Termux; Claude Code is installed with npm.
CLAUDE_INSTALL_METHOD="npm"

# shellcheck source=setup-common.sh
. "$SOURCE_DIR/setup-common.sh"

if [ "${INSTALL_TOOLS:-0}" = "1" ]; then
  echo "Installing tools with pkg..."
  pkg update -y
  pkg install -y git python nodejs-lts ffmpeg curl
  # uv is in the Termux repos; fall back to pip if it isn't available.
  pkg install -y uv || pip install uv
  install_claude_code
fi

copy_agent_setup
set_compact_threshold
install_um
report_tools
print_next_steps

echo ""
echo "Note: Windows-only tools (um win, game installs, VisualBoyAdvance) don't run here."
echo "Use the phone for planning, reviewing notes and light scripted work."
