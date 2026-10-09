# Apps deployed on charminar

This repo tracks the OS layer only. The apps themselves live in their own
repos; this file records where they are deployed and who owns them.

## Rhino CRM (Linux edition)
- Repo: `aska-digital/rhino-crm` (source of truth for the code).
- Deployed to: `/home/muse/crm-os/` on charminar. Owned by the `muse` account.
- Server: `python3 /home/muse/crm-os/server.py`, runs as user `shahid`,
  listens on `127.0.0.1:8741`. Starts at login via the hyprland block.
- Launcher: `launchers/rhino-crm.desktop` (in this repo). Keybind: SUPER+R.
- Database: `/home/muse/crm-os/data/crm.db` (SQLite, WAL mode). Daily backups
  in `data/backups/` (30-day retention). Never open the database file
  directly — use the HTTP API.
- Owner: hyd-nawab. Collaborator: hyd-nizam.

## protean-kit
- Deployed to: `/home/shahid/protean-kit/` on charminar.
- What it is: the on-machine protean agent system (Hermes), installed
  2026-10-09 by hyd-nizam from the aska-digital repos.
- Owner: hyd-nizam.
