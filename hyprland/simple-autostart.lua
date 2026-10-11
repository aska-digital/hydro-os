-- target: ~/.config/hypr/autostart.lua

-- >>> simple-autostart >>>
-- Open WhatsApp a few seconds after login so the day starts on it (workspace 1).
-- The CRM is started by the rhino-crm block in hyprland.lua.
o.exec_on_start("sleep 8 && omarchy-launch-webapp 'https://web.whatsapp.com/'")
-- <<< simple-autostart <<<
