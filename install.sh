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

echo -e "${CYAN} Installing Packages . . . . ${NC}"

echo -e "${CYAN} Running Caelestia Shell > > > > > > . . . . ${NC}"
cd ~
if nix run github:caelestia-dots/shell; then
  echo -e "${GREEN} Caelestia Shell set Succecesful ${NC}"
else
  echo -e "${RED} Caelestia Shell set UnSuccessful${NC}"
  exit 1
fi


echo -e "${CYAN} Installing Grub Theme > > > > > > . . . . ${NC}"
cd ~
if cd CyberGRUB-2077; then
  echo -e "${GREEN} Installing Cyberpunk77 Grub Theme . . . . .${NC}"
  sudo $SHELL ./install.sh -L arasaka

else
  echo -e "${RED} Cyberpunk77 Grub Theme not found${NC}"
  exit 1
fi


