-- target: ~/.config/hypr/bindings.lua
-- Also needs, in ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"):
--   omarchy_default_bindings = false
-- (scripts/apply-simple-desktop.sh does both.)

-- >>> simple-keys >>>
-- Omarchy's default bindings are off (omarchy_default_bindings = false in
-- hyprland.lua). Everything this machine answers to is listed here.

-- Hardware keys: volume, brightness, mute, touchpad on/off.
require("default.hypr.bindings.media")
-- SUPER+C, SUPER+V, SUPER+X: copy, paste, cut in any app.
require("default.hypr.bindings.clipboard")

-- One key per app. Each app has its own workspace (rules in hyprland.lua).
o.bind("SUPER + 1", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind("SUPER + 2", "Gmail", { webapp = "https://mail.google.com", focus = true })
o.bind("SUPER + 3", "Drive", { webapp = "https://drive.google.com", focus = true })
o.bind("SUPER + 4", "Meet", { webapp = "https://meet.google.com", focus = true })
o.bind("SUPER + 5", "Chromium", { launch = "chromium", focus = "^chromium$" })
o.bind("SUPER + 9", "Rhino CRM", "/home/muse/crm-os/crm.sh") -- same as SUPER + R (rhino-crm block)
o.bind("SUPER + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + SHIFT + F", "Files", { omarchy = "nautilus" })

-- Menus and the desktop.
o.bind("SUPER + SPACE", "Menu", "omarchy-menu toggle")
o.bind("SUPER + ESCAPE", "Lock or shut down", "omarchy-menu toggle system")
o.bind("XF86PowerOff", "Power menu", "omarchy-menu toggle system", { locked = true })
o.bind("SUPER + K", "Show these keys", "omarchy-menu-keybindings")
o.bind("SUPER + W", "Close window", hl.dsp.window.close())
o.bind("ALT + TAB", "Next window", hl.dsp.window.cycle_next())
o.bind("SUPER + CTRL + L", "Lock screen", "omarchy-system-lock")
o.bind("PRINT", "Screenshot", "omarchy-capture-screenshot")
o.bind("XF86Calculator", "Calculator", "omacalc")
o.bind("SUPER + comma", "Dismiss notification", "omarchy-shell notifications dismissOne")

-- Laptop lid: lock on close, fix displays on open (same as Omarchy's default).
o.bind("switch:on:Lid Switch", nil, "omarchy-system-lid-close", { locked = true })
o.bind("switch:off:Lid Switch", nil, "omarchy-hyprland-monitor-clamshell", { locked = true })
-- <<< simple-keys <<<
