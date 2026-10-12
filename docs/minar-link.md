# minar-desk: the charminar end of the minar link

`minar-desk` is the charminar end of saga-divan's link. It is installed as
`~/.local/bin/minar-desk` by `scripts/tidy-launchers.sh`.

What it does on charminar:

- Shows popups and clipboard text sent from saga-divan.
- Prompts A for Exo keys with hidden input, and writes them to
  `~/.config/exo/keys.env` (mode 600). Nothing is printed back.
- Runs saga-minar in the tmux session `minar`.

Source of truth for both `minar` (Mac end) and `minar-desk` (this file's
script) is `aska-digital/divan-bus`, in `tools/minar/`. Change them there
first, then copy `minar-desk` here.
