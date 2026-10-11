-- target: ~/.config/hypr/bindings.lua
-- Also needs, in ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"):
--   omarchy_preinstalled_bindings = false
-- (scripts/apply-simple-desktop.sh does both.)

-- >>> simple-bindings >>>
-- One key per app for Shahid. SUPER+1..5 used to switch workspaces; now they
-- open (or jump to) the app that lives on that workspace. Window rules in
-- hyprland.lua pin each app to its workspace, so the effect is the same.
for n = 1, 5 do
  hl.unbind("SUPER + code:" .. tostring(n + 9)) -- was: Switch to workspace n
end
hl.unbind("SUPER + mouse_down") -- was: Scroll active workspace forward
hl.unbind("SUPER + mouse_up") -- was: Scroll active workspace backward
hl.unbind("SUPER + TAB") -- was: Next workspace

o.bind("SUPER + 1", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind("SUPER + 2", "Gmail", { webapp = "https://mail.google.com", focus = true })
o.bind("SUPER + 3", "Drive", { webapp = "https://drive.google.com", focus = true })
o.bind("SUPER + 4", "Meet", { webapp = "https://meet.google.com", focus = true })
o.bind("SUPER + 5", "Chromium", { launch = "chromium", focus = "^chromium$" })
-- SUPER + R (Rhino CRM) is bound in hyprland.lua, rhino-crm block.
-- <<< simple-bindings <<<
