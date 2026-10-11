# Hyprland config blocks

Each file here is one guarded block. Install pattern (same as the CRM used):

1. Remove any previous block with the same markers (`-- >>> name >>>` /
   `-- <<< name <<<`) from the live config first — makes re-runs clean.
2. Back up the live config (`cp target target.bak-<name>`).
3. Append the block.
4. Verify: `Hyprland --verify-config -c <target>`. If it fails, restore the
   backup and stop.
5. `hyprctl reload`.

Lua file (`~/.config/hypr/hyprland.lua`) wins when it exists, otherwise the
`.conf` file. The block below is written for the Lua form; the `.conf` form
is commented inside where it differs.

Keybinds live here, not scattered: SUPER+R opens the CRM (SUPER+C stays
copy — never rebind it).

## Blocks in this directory

| Block | Target file | What it does |
|-------|-------------|--------------|
| `rhino-crm.lua` | `hyprland.lua` | Starts the CRM at login, SUPER+R, workspace 9. |
| `simple-keys.lua` | `bindings.lua` | The complete key set: SUPER+1..5 apps, SUPER+9/R CRM, menu, close, lock, screenshot, copy/paste, hardware keys, lid switch, Jarvis (Caps Lock / F9 hold, SUPER+J chat). Omarchy's defaults are off. |
| `simple-autostart.lua` | `autostart.lua` | Opens WhatsApp a few seconds after login. |
| `simple-input.lua` | `input.lua` | Keyboard layouts us, Arabic, Urdu; Left Alt + Right Alt switches. Caps Lock sends Menu (the Jarvis talk key). |
| `simple-windows.lua` | `hyprland.lua` | One app per workspace (1 to 5, CRM on 9), always maximized, never floating. |

A block's first line may say `-- target: ~/.config/hypr/<file>.lua`;
`scripts/apply-hyprland-block.sh` reads it and appends only the guarded part
(from the `>>>` marker) to that file. Without the header the target is
`hyprland.lua`. `scripts/apply-simple-desktop.sh` applies the whole simple
desktop layer in one go, including the in-place flag
`omarchy_preinstalled_bindings = false` at the top of `hyprland.lua`, which
turns off Omarchy's preinstalled app and web app shortcuts.
