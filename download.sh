#!/usr/bin/env bash

# ==============================================================================
#  COSMOS RICE : Asset & Package Downloader
# ==============================================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

DISTRO="${DISTRO:-arch}"
DOWNLOAD_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/cosmos/downloads"
mkdir -p "$DOWNLOAD_CACHE"

echo -e "${CYAN} Checking and installing core packages for ${DISTRO^^} . . . . ${NC}"

# 1. Package Installation Function
install_package() {
    local bin_name="$1"
    local nix_pkg="$2"
    local arch_pkg="$3"

    if command -v "$bin_name" &> /dev/null; then
        echo -e "${GREEN}[OK] ${bin_name} is installed: $(${bin_name} --version | head -n 1)${NC}"
    else
        echo -e "${YELLOW}[..] ${bin_name} not found. Installing for ${DISTRO^^}...${NC}"
        if [ "$DISTRO" = "nix" ]; then
            nix profile install "nixpkgs#${nix_pkg}"
        else
            sudo pacman -S --needed --noconfirm "$arch_pkg"
        fi

        if command -v "$bin_name" &> /dev/null; then
            echo -e "${GREEN}[OK] ${bin_name} installed successfully.${NC}"
        else
            echo -e "${RED}[ERR] Failed to install ${bin_name}.${NC}"
            exit 1
        fi
    fi
}

install_package "git" "git" "git"
install_package "kitty" "kitty" "kitty"
install_package "fastfetch" "fastfetch" "fastfetch"

# 2. Resilient Git Downloader Function
sync_repo() {
    local repo_url="$1"
    local target_dir="$2"
    local name="$3"

    echo -e "${CYAN}[..] Syncing ${name} . . . .${NC}"
    if [ -d "$target_dir/.git" ]; then
        echo -e "${YELLOW}Updating ${name}...${NC}"
        git -C "$target_dir" pull --ff-only || {
            echo -e "${RED}Fast-forward failed. Re-cloning ${name}...${NC}"
            rm -rf "$target_dir"
            git clone "$repo_url" "$target_dir"
        }
    else
        rm -rf "$target_dir"
        git clone "$repo_url" "$target_dir"
    fi
    echo -e "${GREEN}[OK] ${name} ready at ${target_dir}.${NC}"
}

# Only sync GRUB & SDDM theme repositories on Arch systems where they can be applied
if [ "$DISTRO" = "arch" ]; then
    sync_repo "https://github.com/adnksharp/CyberGRUB-2077" "$DOWNLOAD_CACHE/CyberGRUB-2077" "CyberGRUB-2077"
    sync_repo "https://github.com/Darkkal44/qylock" "$DOWNLOAD_CACHE/qylock" "QYLock SDDM"
else
    echo -e "${YELLOW}[!] NixOS manages system themes declaratively. Skipping mutable theme downloads.${NC}"
fi