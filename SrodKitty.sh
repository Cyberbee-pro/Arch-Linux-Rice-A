#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN} Installing Kitty Configuration . . . . ${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KITTY_SRC="${SCRIPT_DIR}/kitty"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"

mkdir -p "$TARGET_DIR"

if [ -d "$KITTY_SRC" ]; then
    if cp -r "$KITTY_SRC"/* "$TARGET_DIR"/; then
        echo -e "${GREEN} Kitty configs installed Successfully! ${NC}"
    else
        echo -e "${RED} Failed to copy Kitty configs. ${NC}"
        exit 1
    fi
else
    echo -e "${RED} Source kitty folder not found at: ${KITTY_SRC} ${NC}"
    exit 1
fi