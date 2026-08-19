#!/usr/bin/env bash

# ==============================================================================
#  COSMOS RICE : Fastfetch Dynamic ASCII Shell Banner
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASCII_SRC="${SCRIPT_DIR}/ascii_arts"
ASCII_DEST="${XDG_CONFIG_HOME:-$HOME/.config}/Cosmos/ascii_arts"

echo -e "${CYAN}[..] Configuring Dynamic ASCII Art & Shell Launchers . . . .${NC}"

# 1. Sync ASCII Art Files
mkdir -p "$ASCII_DEST"
if [ -d "$ASCII_SRC" ]; then
    cp -r "$ASCII_SRC"/* "$ASCII_DEST"/ 2>/dev/null || true
    echo -e "${GREEN}[OK] ASCII art collection synced to ${ASCII_DEST}.${NC}"
else
    echo -e "${YELLOW}[!] Local ascii_arts directory not found in repo. Utilizing existing configs.${NC}"
fi

# 2. Generate Isolated Injection Block
INJECTION_SNIPPET=$(cat << 'EOF'
# >>> COSMOS_FASTFETCH_BANNER_START >>>
if command -v fastfetch &>/dev/null; then
    ASCII_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/Cosmos/ascii_arts"
    if [ -d "$ASCII_DIR" ] && [ "$(ls -A "$ASCII_DIR" 2>/dev/null)" ]; then
        RANDOM_ART=$(find "$ASCII_DIR" -type f | shuf -n 1)
        fastfetch --logo "$RANDOM_ART"
    else
        fastfetch
    fi
fi
# <<< COSMOS_FASTFETCH_BANNER_END <<<
EOF
)

# 3. Clean Insertion / Replacement Function
inject_into_rc() {
    local rc_file="$1"
    local shell_name="$2"

    [ -f "$rc_file" ] || touch "$rc_file"

    if grep -q "COSMOS_FASTFETCH_BANNER_START" "$rc_file"; then
        echo -e "${YELLOW}[..] Updating existing Fastfetch banner in ${rc_file}...${NC}"
        # Strip old block between boundary delimiters
        sed -i '/# >>> COSMOS_FASTFETCH_BANNER_START >>>/,/# <<< COSMOS_FASTFETCH_BANNER_END <<</d' "$rc_file"
    fi

    # Append fresh block
    echo -e "\n$INJECTION_SNIPPET" >> "$rc_file"
    echo -e "${GREEN}[OK] Injected dynamic Fastfetch startup into ${shell_name} (${rc_file}).${NC}"
}

# Apply to all active shells present in user home
[ -f "$HOME/.bashrc" ] || touch "$HOME/.bashrc"
inject_into_rc "$HOME/.bashrc" "Bash"

if [ -f "$HOME/.zshrc" ] || command -v zsh &>/dev/null; then
    inject_into_rc "$HOME/.zshrc" "Zsh"
fi