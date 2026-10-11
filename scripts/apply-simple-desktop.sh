#!/bin/bash
# Apply the whole "simple desktop" layer for Shahid. Re-runnable.
# Run as Shahid, no sudo. Verifies the Hyprland config after each block.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
H="$HOME/.config/hypr/hyprland.lua"

# 1. Turn off all Omarchy default bindings (must sit before
#    require("default.hypr.omarchy"), so it is an in-place edit, not a block).
if ! grep -q '^omarchy_default_bindings = false' "$H"; then
  sed -i 's/^-- omarchy_default_bindings = false$/omarchy_default_bindings = false/' "$H"
fi
grep -q '^omarchy_default_bindings = false' "$H" || { echo "flag not set in $H"; exit 1; }

# 2. Guarded blocks.
bash "$HERE/apply-hyprland-block.sh" simple-keys
bash "$HERE/apply-hyprland-block.sh" simple-input
bash "$HERE/apply-hyprland-block.sh" simple-windows
bash "$HERE/apply-hyprland-block.sh" simple-autostart

# 3. Whole-file knobs (display scale, idle timers).
cp "$HERE/../config/hypr/monitors.lua" "$HOME/.config/hypr/monitors.lua"
cp "$HERE/../config/omarchy/shell.json" "$HOME/.config/omarchy/shell.json"
mkdir -p "$HOME/.config/omarchy/extensions"
cp "$HERE/../config/omarchy/extensions/omarchy-menu.jsonc" "$HOME/.config/omarchy/extensions/omarchy-menu.jsonc"
Hyprland --verify-config -c "$H" >/dev/null && hyprctl reload >/dev/null

# 4. Commands.
omarchy theme set flexoki-light   # light theme: daylight readability
omarchy display text size 16
omarchy-toggle-enabled suspend-off || omarchy toggle suspend
bash "$HERE/install-webapps.sh"
bash "$HERE/tidy-launchers.sh"
bash "$HERE/../jarvis/install.sh"
echo "done. GDK_SCALE needs a fresh login to reach every app."
