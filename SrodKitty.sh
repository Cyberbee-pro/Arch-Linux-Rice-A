#!/usr/bin/env bash

# ==============================================================================
#  COSMOS RICE : Kitty Dotfile Deployer
# ==============================================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KITTY_SRC="${SCRIPT_DIR}/kitty"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"

echo -e "${CYAN}[..] Deploying Kitty Terminal Configurations . . . .${NC}"

if [ ! -d "$KITTY_SRC" ]; then
    echo -e "${RED}[ERR] Source folder not found: ${KITTY_SRC}${NC}"
    exit 1
fi

# Create timestamped backup if existing config directory is present
if [ -d "$TARGET_DIR" ] && [ "$(ls -A "$TARGET_DIR" 2>/dev/null)" ]; then
    BACKUP_PATH="${TARGET_DIR}.backup_$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}[..] Backing up existing Kitty config to: ${BACKUP_PATH}${NC}"
    cp -rL "$TARGET_DIR" "$BACKUP_PATH"
fi

mkdir -p "$TARGET_DIR"

# Use --remove-destination to overwrite immutable/Nix store symlinks cleanly
if cp -r --remove-destination "$KITTY_SRC"/* "$TARGET_DIR"/; then
    echo -e "${GREEN}[OK] Kitty configurations deployed successfully to ${TARGET_DIR}.${NC}"
else
    echo -e "${RED}[ERR] Failed to copy Kitty configuration files.${NC}"
    exit 1
fi