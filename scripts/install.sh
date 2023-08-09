#!/bin/zsh

if [[ $EUID -ne 0 ]]; then
  echo "${RED}Error: This script must be run as root${NC}" 
  exit 1
fi

GREEN='\033[0;32m'
YELLOW="\033[0;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC='\033[0m'

INSTALL_DIR="/usr/local/bin"
COMMAND_NAME="quick-spring"

cp create_spring_boot.sh "$INSTALL_DIR/$COMMAND_NAME"
chmod +x "$INSTALL_DIR/$COMMAND_NAME"

echo "${GREEN}Installation complete of ${COMMAND_NAME} ${NC}"

COMMAND_NAME="systats"

cp systats.sh "$INSTALL_DIR/$COMMAND_NAME"
chmod +x "$INSTALL_DIR/$COMMAND_NAME"

echo "${GREEN}Installation complete of ${COMMAND_NAME} ${NC}"
