#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW="\033[0;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC='\033[0m'

main() {
  ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
}

main
