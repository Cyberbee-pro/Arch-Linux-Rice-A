#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # Reset / No Color

echo -e "${CYAN} Installing Kitty Configuration . . . . ${NC}"

# 1. Ensure target directory exists
mkdir -p ~/.config/kitty

# 2. Copy all configuration files from your project's kitty directory
KITTY_SRC="/data/programing/Linux_projects/Rice_A/kitty"

if cp -r "$KITTY_SRC"/* ~/.config/kitty/; then
    echo -e "${GREEN} Kitty configs installed Successfully! ${NC}"
else
    echo -e "${RED} Failed to install Kitty configs. ${NC}"
fi