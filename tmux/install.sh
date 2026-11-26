#!/usr/bin/env bash
# Links tmux/.tmux.conf to ~/.tmux.conf. Run as your user (not with sudo), on
# Debian/WSL or Arch/EndeavourOS. The status line reads tmux/status.sh from
# ~/dotfiles, so clone the repo there.

GREEN='\033[0;32m'
RED="\033[0;31m"
NC='\033[0m'

main() {
  if ! command -v tmux &> /dev/null; then
    echo -e "${RED}tmux isn't installed. Aborting.${NC}"
    exit 1
  fi

  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  ln -sf "$dir/.tmux.conf" "$HOME/.tmux.conf"
  echo -e "${GREEN}Linked $HOME/.tmux.conf -> $dir/.tmux.conf${NC}"
}

main
