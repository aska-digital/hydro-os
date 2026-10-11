# config/ — copies of user config files we changed

These mirror files under `~/.config/`. Omarchy ships them as user-editable
knobs (not guarded blocks), so we track the whole file. Copy back with:

    cp config/hypr/monitors.lua ~/.config/hypr/monitors.lua
    cp config/omarchy/shell.toml ~/.config/omarchy/shell.toml
    cp config/omarchy/shell.json ~/.config/omarchy/shell.json

| File | What we changed |
|------|-----------------|
| `hypr/monitors.lua` | 15.6" 1080p panel: monitor scale 1.5, GDK_SCALE 1 (was auto / 2). |
| `omarchy/shell.toml` | Written by `omarchy display text size 16` (shell/GTK/terminal text 16 px). |
| `omarchy/shell.json` | Idle: screensaver after 15 min, lock after 60 min (was 2.5 / 5 min). Bar: no agents, update or monitor widgets; clock shows day, date and 12-hour time. |
| `omarchy/extensions/omarchy-menu.jsonc` | Main menu: Apps, Rhino CRM, Keys, About, System. Install, Remove, Update, Setup, Style, Learn, Trigger hidden. |
