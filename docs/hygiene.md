# Safe hygiene commands — charminar

From the 2026-10-09 system audit (read-only; nothing was changed then).
Run these in a terminal. Each one is low risk. Do not run anything else
from this list if unsure.

## See what updates are pending (safe, read-only)
```
checkupdates
```

## Free ~400MB: clear the pacman download cache (safe)
```
paccache -r
```
This removes only cached old package files, not installed software.

## Trim the system journal (safe)
```
sudo journalctl --vacuum-size=50M
```
Keeps the last 50MB of logs.

## Check for orphaned packages (read-only)
```
pacman -Qdtq
```
If it lists something, remove with `sudo pacman -Rns <name>` — only what
you recognize.

## Full upgrade — REVIEW BEFORE RUN
```
checkupdates        # preview first
sudo pacman -Syu    # then upgrade, then reboot once
```
Rule of thumb: small batches every 2–4 weeks beat one giant upgrade after
months. Reboot after kernel or graphics updates. Save work first; the CRM
restarts at login by itself.

## Do NOT touch
- The CRM server process (`python3 /home/muse/crm-os/server.py`) — never
  stop, kill, or restart it yourself. If it misbehaves, tell Nawab.
- Anything under `/home/muse/` — that is the CRM owner's area.
- `paccache -rk0` (deletes all cached packages) — not needed.
