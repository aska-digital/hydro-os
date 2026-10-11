-- target: ~/.config/hypr/hyprland.lua (appended after the rhino-crm block)

-- >>> simple-windows >>>
-- One app per workspace, always maximized, never floating, so Shahid never
-- sees tiling. Classes are what Chromium gives each web app window.
o.window("^chrome-web\\.whatsapp\\.com__-Default$", { workspace = "1", maximize = true, float = false })
o.window("^chrome-mail\\.google\\.com__.*-Default$", { workspace = "2", maximize = true, float = false }) -- also the mailto compose window
o.window("^chrome-drive\\.google\\.com__-Default$", { workspace = "3", maximize = true, float = false })
o.window("^chrome-meet\\.google\\.com__-Default$", { workspace = "4", maximize = true, float = false })
o.window("^chromium$", { workspace = "5", maximize = true, float = false })
-- Rhino CRM: workspace 9 comes from the rhino-crm block above; this only maximizes it.
o.window("^chrome-127\\.0\\.0\\.1__-Default$", { maximize = true, float = false })
-- <<< simple-windows <<<
