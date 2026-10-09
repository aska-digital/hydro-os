# hydro-os

The customization layer on top of Omarchy that makes charminar Shahid's
machine. Not a fork — stock Omarchy underneath, our changes tracked here.

- Pinned Omarchy version: see `VERSION`.
- Machine: charminar (Omarchy Linux, Hyprland/Wayland).
- Team: hydro-team (hyd-nawab + hyd-nizam).

## What lives here

| Path         | What it is |
|--------------|------------|
| `hyprland/`  | Guarded Hyprland config blocks we append (Lua or .conf). Each block is marked so upgrades stay clean. |
| `launchers/` | `.desktop` files for the app menu (installed to `~/.local/share/applications`). |
| `scripts/`   | One-time setup scripts. Run as Shahid (no sudo), never as root. |
| `docs/`      | Plain-language guides: daily use, safe hygiene commands. |
| `apps/`      | Notes on the apps deployed on charminar and where their real repos live. |

## What does NOT live here

- The CRM source code — that lives in `aska-digital/rhino-crm` (deployed to `/home/muse/crm-os/`).
- Shahid's personal data, the CRM database, backups, credentials, or Drive IDs.
- Anything from stock Omarchy — we track our layer only.

## Rules

1. Never break the running CRM (`/home/muse/crm-os`, server on `127.0.0.1:8741`). See `docs/operating-guide.md`.
2. Hyprland changes go through the guarded-block pattern: remove the old block first, append the new one, verify with `Hyprland --verify-config`, keep a backup.
3. Test on charminar with Shahid around — reboots and restarts are his call.
4. Keep it small. If a change needs patching Omarchy itself (not just config), that is a fork discussion — raise it with Shahid first.
