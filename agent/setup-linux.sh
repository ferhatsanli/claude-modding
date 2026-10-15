#!/usr/bin/env bash
# Sets up the modding root for Claude Code on Linux (Fedora, Debian/Ubuntu, Arch).
# Usage (from the repo's agent folder):
#   bash setup-linux.sh                        # root: ~/Modding
#   bash setup-linux.sh ~/Games/Modding        # custom root
#   INSTALL_TOOLS=1 bash setup-linux.sh        # also install tools (uses sudo)

set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="${1:-$HOME/Modding}"
SHELL_RC="$HOME/.bashrc"
case "${SHELL:-}" in
  */zsh) SHELL_RC="$HOME/.zshrc" ;;
esac

# shellcheck source=setup-common.sh
. "$SOURCE_DIR/setup-common.sh"

install_linux_tools() {
  if command -v dnf >/dev/null 2>&1; then
    # Fedora: ffmpeg (full) comes from RPM Fusion; ffmpeg-free is in the main repos.
    sudo dnf install -y git python3 python3-pip pipx nodejs ffmpeg-free curl
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y git python3 python3-pip python3-venv pipx nodejs npm ffmpeg curl
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm git python python-pip python-pipx nodejs npm ffmpeg curl
  else
    echo "Unknown package manager. Install git, python3, ffmpeg, nodejs and curl yourself."
    return
  fi
  if ! command -v uv >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
  fi
}

if [ "${INSTALL_TOOLS:-0}" = "1" ]; then
  echo "Installing tools..."
  install_linux_tools
  install_claude_code
fi

copy_agent_setup
set_compact_threshold
install_um
report_tools
print_next_steps
