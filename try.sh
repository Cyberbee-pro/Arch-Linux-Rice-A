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



if command -v cowsay &> /dev/null; then
  echo -e "${GREEN}Cowsay is installed: $(cowsay --version) ${NC}"
else
  echo -e "${RED}cowsay is not installed. . . . . installing cowsay. . . . .${NC}"
    pacman -S cowsay
    cowsay "I am installed!"
fi
#git clone https://github.com/Darkkal44/qylock

