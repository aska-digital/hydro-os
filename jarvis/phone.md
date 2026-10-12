# Controlling charminar from Shahid's phone

The Claude app on the phone can drive a Claude Code session on charminar
through **Remote Control**: the session runs here, with the Jarvis prompt and
the `jarvis-do` actions, and appears in the app's Code tab. Whatever he types
or dictates in the app runs on this machine.

## Status (2026-10-11, 5:55 PM)

Remote Control is **on**. Ahraz enabled it in the admin console; charminar was
then enrolled as a trusted device for the account (an email confirms it).
`jarvis-remote.service` is enabled and active; the session shows in the Claude
app's Code tab as "charminar" and answered a test question as Jarvis.

Note: `claude remote-control` (the subcommand) still reports the policy as
disabled; the `--remote-control` flag on an interactive session is what works.

## The standing session

    systemctl --user status jarvis-remote.service
    systemctl --user restart jarvis-remote.service   # after changing prompt.md or the session CLAUDE.md

`jarvis-remote.service` (in this directory) keeps a tmux session named
`jarvis` running `claude --remote-control charminar` in `~/.local/share/jarvis/session`
with the Jarvis prompt and the same tool limits as the voice mode. It restarts
if it stops. The session then shows up in the Claude app as "charminar".

Check: `tmux attach -t jarvis` on charminar shows the live session; detach with
Ctrl-b d.

## Until then

The phone can still reach charminar over Tailscale (same account), for
example with a terminal app and `ssh shahid@charminar`, then `jarvis-chat`.
That is a developer path, not something for Shahid.

## Design work

FreeCAD design ("Making things") works only at the desk. The phone session (jarvis-remote) does not have the FreeCAD tools; if he asks from the phone, say it can be done when he is at charminar.
