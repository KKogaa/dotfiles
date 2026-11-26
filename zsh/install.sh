#!/usr/bin/env bash
# Links zsh/.zshrc to ~/.zshrc. Put machine-local secrets in ~/.zshrc.local.

GREEN='\033[0;32m'
NC='\033[0m'

main() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  ln -sf "$dir/.zshrc" "$HOME/.zshrc"
  echo -e "${GREEN}Linked $HOME/.zshrc -> $dir/.zshrc${NC}"
}

main
