#!/bin/bash
# Append a guarded Hyprland block from ../hyprland/ to the live config.
# Re-runnable: the old block is removed first. Verifies before reload,
# restores the backup on failure. Run as Shahid (no sudo).
# Usage:  bash apply-hyprland-block.sh rhino-crm
set -u
NAME="${1:?usage: apply-hyprland-block.sh <name>}"
SRC="$(cd "$(dirname "$0")/../hyprland" && pwd)/$NAME.lua"
[ -f "$SRC" ] || { echo "no such block: $NAME"; exit 1; }
CONF_DIR="$HOME/.config/hypr"
LUA="$CONF_DIR/hyprland.lua"
CONF="$CONF_DIR/hyprland.conf"
if [ -f "$LUA" ]; then TARGET="$LUA"; else TARGET="$CONF"; fi
MARK="$NAME >>>"
python3 - "$TARGET" "$MARK" <<'PYEOF'
import sys
p, mark = sys.argv[1], sys.argv[2]
lines = open(p).read().splitlines(keepends=True)
out, skip = [], False
for ln in lines:
    if mark in ln and ">>>" in ln:
        skip = True
        continue
    if mark in ln and "<<<" in ln:
        skip = False
        continue
    if not skip:
        out.append(ln)
open(p, "w").writelines(out)
PYEOF
cp "$TARGET" "$TARGET.bak-$NAME"
cat "$SRC" >> "$TARGET"
if Hyprland --verify-config -c "$TARGET" >/tmp/hydro-block-verify.out 2>&1; then
  hyprctl reload >/dev/null 2>&1 || true
  echo "applied $NAME, config reloaded"
else
  echo "verify FAILED, restoring backup:"
  cat /tmp/hydro-block-verify.out
  cp "$TARGET.bak-$NAME" "$TARGET"
  exit 1
fi
