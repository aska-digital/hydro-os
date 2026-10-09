#!/bin/bash
# Install a .desktop launcher from ../launchers/ into the app menu.
# Run as Shahid (no sudo):  bash install-launcher.sh rhino-crm
set -u
NAME="${1:?usage: install-launcher.sh <name>}"
SRC="$(cd "$(dirname "$0")/../launchers" && pwd)/$NAME.desktop"
[ -f "$SRC" ] || { echo "no such launcher: $NAME"; exit 1; }
DEST="$HOME/.local/share/applications/$NAME.desktop"
mkdir -p "$(dirname "$DEST")"
cp "$SRC" "$DEST"
echo "installed: $DEST"
