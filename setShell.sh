#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # Reset / No Color

echo -e "${CYAN} Setting up ASCII Art Configuration . . . . ${NC}"

# 1. Resolve Script & Target Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_ASCII_SRC="${SCRIPT_DIR}/ascii_arts"
TARGET_ASCII_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/Cosmos/ascii_arts"

# 2. Deploy ASCII Files to ~/.config/Cosmos/ascii_arts
mkdir -p "$TARGET_ASCII_DIR"

if [ -d "$LOCAL_ASCII_SRC" ]; then
    cp -r "$LOCAL_ASCII_SRC"/* "$TARGET_ASCII_DIR"/ 2>/dev/null
    echo -e "${GREEN}==>${NC} Synced ASCII art to ${YELLOW}${TARGET_ASCII_DIR}${NC}"
else
    echo -e "${YELLOW}==>${NC} Notice: No local 'ascii_arts' directory found alongside script. Using existing files in config if present."
fi

# 3. Detect Active / Default Shell
DETECTED_SHELL="$(basename "$SHELL")"
TARGET_RC=""

case "$DETECTED_SHELL" in
    zsh)
        TARGET_RC="$HOME/.zshrc"
        echo -e "${BLUE}==>${NC} Detected Shell: ${YELLOW}Zsh${NC} (${TARGET_RC})"
        ;;
    bash)
        TARGET_RC="$HOME/.bashrc"
        echo -e "${BLUE}==>${NC} Detected Shell: ${YELLOW}Bash${NC} (${TARGET_RC})"
        ;;
    *)
        if [ -f "$HOME/.zshrc" ]; then
            TARGET_RC="$HOME/.zshrc"
        elif [ -f "$HOME/.bashrc" ]; then
            TARGET_RC="$HOME/.bashrc"
        else
            echo -e "${RED}Error: Neither .zshrc nor .bashrc could be located.${NC}"
            exit 1
        fi
        echo -e "${YELLOW}==>${NC} Unrecognized shell '$DETECTED_SHELL', defaulting to: ${TARGET_RC}"
        ;;
esac

# 4. Define Universal Shell Injection Block (Matched to Cosmos directory)
BANNER_SNIPPET=$(cat << 'EOF'

# --- Fastfetch Random ASCII Banner ---
if command -v fastfetch &>/dev/null; then
    ASCII_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/Cosmos/ascii_arts"
    if [ -d "$ASCII_DIR" ]; then
        RANDOM_ART=$(find "$ASCII_DIR" -type f -name "*.txt" 2>/dev/null | shuf -n 1)
        [ -n "$RANDOM_ART" ] && fastfetch --logo "$RANDOM_ART" || fastfetch
    else
        fastfetch
    fi
fi
# -------------------------------------
EOF
)

# 5. Inject Into Shell RC (Idempotent)
if grep -q "Fastfetch Random ASCII Banner" "$TARGET_RC" 2>/dev/null; then
    echo -e "${YELLOW}==>${NC} Fastfetch banner is already configured in ${TARGET_RC}."
else
    echo "$BANNER_SNIPPET" >> "$TARGET_RC"
    echo -e "${GREEN} Successfully added dynamic ASCII banner to ${TARGET_RC}! ${NC}"
fi