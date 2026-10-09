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
