# Controlling charminar from Shahid's phone

The Claude app on the phone can drive a Claude Code session on charminar
through **Remote Control**: the session runs here, with the Jarvis prompt and
the `jarvis-do` actions, and appears in the app's Code tab. Whatever he types
or dictates in the app runs on this machine.

## Status (2026-10-11)

Remote Control is **disabled by the organisation's policy** on this account:

    claude remote-control
    Error: Remote Control is disabled by your organization's policy.

An organisation admin (Ahraz) turns it on in the Claude admin console
(Settings > Claude Code > Remote Control). Nothing on charminar is needed
beyond that.

## Once it is enabled

Start the standing session (as Shahid, no sudo):

    systemctl --user enable --now jarvis-remote.service

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
