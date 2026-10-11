#!/bin/bash
# Install the FreeCAD side of Jarvis "Making things". Needs: sudo pacman -S --needed freecad uv
set -eu
H="$(cd "$(dirname "$0")" && pwd)"
MOD="$HOME/.local/share/FreeCAD/v1-1/Mod"
mkdir -p "$MOD" "$HOME/Designs" "$HOME/.local/share/jarvis"
rm -rf "$MOD/FreeCADMCP"
cp -r "$H/freecad-mcp-addon/FreeCADMCP" "$MOD/FreeCADMCP"
# RPC server starts with FreeCAD, localhost only, no remote connections.
cat > "$HOME/.local/share/FreeCAD/v1-1/freecad_mcp_settings.json" <<'JSON'
{"remote_enabled": false, "allowed_ips": "127.0.0.1", "auto_start_rpc": true, "auth_token": ""}
JSON
# MCP server config, used only by jarvis-ask and jarvis-chat (--mcp-config).
cp "$H/freecad-mcp.json" "$HOME/.local/share/jarvis/freecad-mcp.json"
# Warm the uvx cache with the pinned server.
uvx --from "git+https://github.com/neka-nat/freecad-mcp@4751f953636f46b825424320c2f76e11159dd8c0" freecad-mcp --help >/dev/null
echo "FreeCAD addon installed."
