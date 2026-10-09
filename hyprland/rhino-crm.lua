-- >>> rhino-crm >>>
-- Starts the Rhino CRM at login, pins its window, SUPER+R jumps to it.
-- .conf form:
--   exec-once = /home/muse/crm-os/crm.sh
--   bind = SUPER, R, exec, /home/muse/crm-os/crm.sh
--   windowrule = match:class ^(chrome-127\.0\.0\.1__-Default)$, workspace 9 silent
hl.on("hyprland.start", function() hl.exec_cmd("/home/muse/crm-os/crm.sh") end)
hl.bind("SUPER + R", hl.dsp.exec_cmd("/home/muse/crm-os/crm.sh"))
hl.window_rule({ match = { class = "chrome-127.0.0.1__-Default" }, workspace = "9 silent" })
-- <<< rhino-crm <<<
