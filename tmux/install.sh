#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW="\033[0;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC='\033[0m'


main() {
  if [[ $EUID -ne 0 ]]; then
    echo "${RED}Error: This script must be run as root${NC}" 
    exit 1
  fi

  test type tmux >/dev/null 2>&1 && echo "TMUX isn't installed. Aborting." && exit 1
  ln -sf "$PWD/.tmux.conf" "$HOME/.tmux.conf"

  if ! command -v spotifycli &> /dev/null
  then
    echo "Spotifycli could not be found"
    echo "Installing Spotifycli"

    INSTALL_DIR="/usr/local/bin"
    COMMAND_NAME="spotifycli"

    cp spotifycli.sh "$INSTALL_DIR/$COMMAND_NAME"
    chmod +x "$INSTALL_DIR/$COMMAND_NAME"

    echo "${GREEN}Installation complete of ${COMMAND_NAME} ${NC}"
  else
    echo "Spotifycli already installed."
    exit
  fi

}

main
