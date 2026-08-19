#!/bin/bash
set -e

# Run each stage relative to main.sh's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/download.sh"
"$SCRIPT_DIR/install.sh"
"$SCRIPT_DIR/srodKitty.sh"
"$SCRIPT_DIR/setShell.sh"