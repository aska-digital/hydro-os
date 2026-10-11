-- target: ~/.config/hypr/input.lua

-- >>> simple-input >>>
-- English, Arabic, Urdu keyboards. Switch with Left Alt + Right Alt together.
-- Caps Lock goes back to plain Caps Lock (Omarchy's compose-on-Caps is off).
hl.config({
  input = {
    kb_layout = "us,ara,pk",
    kb_variant = "",
    kb_options = "grp:alts_toggle",
  },
})
-- <<< simple-input <<<
