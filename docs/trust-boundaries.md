# Trust boundaries on charminar

Checked on the machine on 2026-10-12. Facts first, decisions marked as such.

## One account runs everything

Everything that runs for Shahid runs as the account `shahid`: the desktop
session, the Jarvis voice and typed sessions, the phone session
(`jarvis-remote.service`), the headless agent session in tmux, and the CRM
server itself (`python3 /home/muse/crm-os/server.py` runs as shahid). The
`muse` account owns the CRM files but runs nothing. So any process running as
shahid can read any file shahid can read, and write any file shahid can write.
That is the boundary for every item below.

## The CRM files

Checked with `ls -ld` and `find /home/muse -writable`:

| Path | Mode, owner | Writable by shahid |
|------|-------------|--------------------|
| /home/muse | 755 muse | no |
| /home/muse/crm-os | 755 muse | no |
| /home/muse/crm-os/crm.sh, server.py | 755 muse | no |
| /home/muse/crm-os/data | 777 muse | yes |
| data/crm.db, data/backups, data/server.log | (inside data) | yes |

Shahid's session cannot change the CRM code or its launcher. It can write the
database. That is by design (`apps/README.md`: data is 777 so the server can
write the database whichever user runs it) and cannot be avoided while the
server runs as shahid: whoever runs the server can write its database
regardless of directory modes. The Jarvis action list only reads the CRM
(`GET /api/leads`, `GET /api/health`); it has no write action.

To tighten this: run the server as `muse` (a service under that account) and
make `data/` 775 owned by muse. Then a session as shahid would only have the
HTTP API. That needs sudo, so it is Ahraz's call. Nothing changes until then.

## API keys

`scripts/minar-desk keys-prompt` writes Exo API keys to
`~/.config/exo/keys.env` with mode 600. At check time that file does not
exist on charminar; no keys have been placed. If they are placed, mode 600
keeps other accounts out, but every process running as shahid can read them:
the headless tmux session (started with `--dangerously-skip-permissions`),
the phone session, the voice sessions, and the CRM server.

Two ways to go: keep the keys off charminar unless a job here needs them, or
accept that keys on charminar trust everything that runs as shahid. This
document records the facts; the choice is Ahraz's.

## The suspend toggle

`omarchy toggle suspend` sets or clears the flag file
`~/.local/state/omarchy/toggles/suspend-off`. The only reader of that flag is
the Omarchy menu (`/usr/share/omarchy/default/omarchy/omarchy-menu.jsonc`): it
hides the "Suspend" entry from the System menu while the flag is set. It
changes nothing about power management.

Checked on charminar: the flag is set; logind `HandleLidSwitch` is `suspend`
(the default, left commented in `/etc/systemd/logind.conf`); `sleep.target`
is available. Closing the lid runs `omarchy-system-lid-close`, which locks
the screen when no external monitor is attached, and then logind suspends
the machine as usual. The laptop does sleep in a bag. Only the menu entry is
gone, which is the intent: one less thing for Shahid to press by accident.

`scripts/apply-simple-desktop.sh` runs
`omarchy-toggle-enabled suspend-off || omarchy toggle suspend`: it sets the
flag only when it is not already set, so re-running the script never flips
suspend back into the menu.
