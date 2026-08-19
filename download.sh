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

echo -e "${CYAN} Downloading Required Packages . . . . ${NC}"

# Check for Git
if command -v git &> /dev/null; then
    echo -e "${GREEN}Git is installed: $(git --version) ${NC}"
else
    echo -e "${RED}Git is not installed. . . . . ${BLUE}installing Git. . . . .${NC}"
    
    if command -v nix &> /dev/null; then
        nix profile install nixpkgs#git
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --noconfirm git
    else
        echo -e "${RED} Package manager not recognized. Please install git manually.${NC}"
        exit 1
    fi

    if command -v git &> /dev/null; then
        echo -e "${GREEN}Git ${MAGENTA}Installed!${NC}"
    else
        echo -e "${RED} GIT NOT Installed! ${CYAN} Install Git and try again${NC}"
        sleep 2
        exit 1
    fi
fi

# Clone / Update CyberGRUB-2077
echo -e "${CYAN} Downloading Grub Theme . . . . ${NC}"
if [ -d "$HOME/CyberGRUB-2077" ]; then
    echo -e "${YELLOW}CyberGRUB-2077 already exists, pulling updates...${NC}"
    git -C "$HOME/CyberGRUB-2077" pull
else
    if git clone https://github.com/adnksharp/CyberGRUB-2077 "$HOME/CyberGRUB-2077"; then
        echo -e "${GREEN} Downloading CyberGRUB-2077 Grub Theme Successful. . . . .${NC}"
    else
        echo -e "${RED} Downloading CyberGRUB-2077 Failed${NC}"
        exit 1
    fi
fi

# Clone / Update QYLock
echo -e "${CYAN} Downloading QYLock > > > > > > . . . . ${NC}"
if [ -d "$HOME/qylock" ]; then
    echo -e "${YELLOW}qylock already exists, pulling updates...${NC}"
    git -C "$HOME/qylock" pull
else
    if git clone https://github.com/Darkkal44/qylock "$HOME/qylock"; then
        echo -e "${GREEN} Downloading QYLock Successful ${NC}"
    else
        echo -e "${RED} Downloading QYLock Unsuccessful${NC}"
        exit 1
    fi
fi