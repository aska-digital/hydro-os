#!/bin/bash
# Apply the whole "simple desktop" layer for Shahid. Re-runnable.
# Run as Shahid, no sudo. Verifies the Hyprland config after each block.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
H="$HOME/.config/hypr/hyprland.lua"

# 1. Turn off Omarchy's preinstalled app/webapp bindings (must sit before
#    require("default.hypr.omarchy"), so it is an in-place edit, not a block).
sed -i 's/^-- omarchy_preinstalled_bindings = false$/omarchy_preinstalled_bindings = false/' "$H"
grep -q '^omarchy_preinstalled_bindings = false' "$H" || { echo "flag not set in $H"; exit 1; }

# 2. Guarded blocks.
bash "$HERE/apply-hyprland-block.sh" simple-bindings
bash "$HERE/apply-hyprland-block.sh" simple-input
bash "$HERE/apply-hyprland-block.sh" simple-windows

# 3. Whole-file knobs (display scale, idle timers).
cp "$HERE/../config/hypr/monitors.lua" "$HOME/.config/hypr/monitors.lua"
cp "$HERE/../config/omarchy/shell.json" "$HOME/.config/omarchy/shell.json"
Hyprland --verify-config -c "$H" >/dev/null && hyprctl reload >/dev/null

# 4. Commands.
omarchy display text size 16
omarchy-toggle-enabled suspend-off || omarchy toggle suspend
bash "$HERE/install-webapps.sh"
echo "done. GDK_SCALE needs a fresh login to reach every app."
