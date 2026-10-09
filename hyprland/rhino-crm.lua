-- >>> rhino-crm >>>
-- Starts the Rhino CRM at login, pins its window, SUPER+R jumps to it.
-- Uses Omarchy's own helpers so the block matches stock binding conventions.
-- NOTE: keybind + window rule register on a fresh Hyprland config parse
-- (next login), not on `hyprctl reload` - see hydro-os issue on SUPER+R.
-- .conf equivalent (for reference):
--   exec-once = /home/muse/crm-os/crm.sh
--   bind = SUPER, R, exec, /home/muse/crm-os/crm.sh
--   windowrule = match:class ^(chrome-127\.0\.0\.1__-Default)$, workspace 9 silent
o.exec_on_start("/home/muse/crm-os/crm.sh")
o.bind("SUPER + R", "Rhino CRM", "/home/muse/crm-os/crm.sh")
hl.window_rule({ match = { class = "chrome-127.0.0.1__-Default" }, workspace = "9 silent" })
-- <<< rhino-crm <<<
