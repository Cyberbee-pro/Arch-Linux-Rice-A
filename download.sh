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


if command -v git &> /dev/null; then
    echo "${GREEN}Git is installed: $(git --version) ${NC}"
else
    echo "${RED}Git is not installed. . . . . ${BLUE}installing Git. . . . .${NC}"
    
    if nix profile install nixpkgs#git; then 
        echo -e "${GREEN}Git ${MAGENTA}Installed!!!${NC}"
      else 
        echo -e "${RED} GIT NOT Installed!!!! ${CYAN} Install Git and try again${NC}"
        sleep 2
        exit 1
    fi
fi


echo -e "${CYAN} Downloading Grub Theme . . . ."
cd ~
if git clone https://github.com/adnksharp/CyberGRUB-2077; then
  echo -e "${GREEN} Downloading CyberGRUB-2077 Grub Theme Succecesful. . . . .${NC}"
else
  echo -e "${RED} Downloading CyberGRUB-2077 Failed"
  exit 1
fi


echo -e "${CYAN} Downloading QYLock > > > > > > . . . . ${NC}"
cd ~
if git clone https://github.com/Darkkal44/qylock; then
  echo -e "${GREEN} Downloading QYLock Succecesful ${NC}"
else
  echo -e "${RED} Downloading QYLock UnSuccessful${NC}"
  exit 1
fi 




