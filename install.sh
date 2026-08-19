#!/bin/bash

set -e


# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # Reset / No Color

echo -e "${CYAN} Installing Packages . . . . ${NC}"

# Caelestia Shell
echo -e "${CYAN} Running Caelestia Shell > > > > > > . . . . ${NC}"
if command -v nix &> /dev/null; then
    if nix run github:caelestia-dots/shell; then
        echo -e "${GREEN} Caelestia Shell set Successful ${NC}"
    else
        echo -e "${RED} Caelestia Shell set Unsuccessful${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW} Nix command not found. Skipping 'nix run' step. ${NC}"
fi

# CyberGRUB-2077
echo -e "${CYAN} Installing Grub Theme > > > > > > . . . . ${NC}"
if [ -d "$HOME/CyberGRUB-2077" ]; then
    echo -e "${GREEN} Installing Cyberpunk77 Grub Theme . . . . .${NC}"
    cd "$HOME/CyberGRUB-2077" || exit 1
    sudo bash ./install.sh -L arasaka
else
    echo -e "${RED} Cyberpunk77 Grub Theme directory not found${NC}"
    exit 1
fi

# QYLock SDDM Theme
echo -e "${CYAN} Installing QYLock Theme > > > > > > . . . . ${NC}"
if [ -d "$HOME/qylock" ]; then
    echo -e "${GREEN} Installing QYLock Theme . . . . .${NC}"
    cd "$HOME/qylock" || exit 1
    chmod +x sddm.sh && sudo ./sddm.sh
else
    echo -e "${RED} QYLock Theme directory not found${NC}"
    exit 1
fi