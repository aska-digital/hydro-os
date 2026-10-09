# Daily guide — charminar

## Open the CRM
Press SUPER+R, or open "Rhino CRM" from the app menu. It opens on workspace 9.

## Record a call
1. Find the company in the Leads list.
2. Open it, write what happened in the activity log, save.

## Set a next action
On the lead, pick the next action (call, email, visit) and a date.
Overdue follow-ups pop up as a desktop notification once a day.

## Check the Drive sync
The CRM pulls the web app's changes from Google Drive by itself, every hour.
If the sync status looks old or shows an error, tell Nawab — do not try to
fix the database yourself.

## If the CRM does not open
1. Wait a few seconds and press SUPER+R again.
2. If it still does not open, tell Nawab what you see. Do not delete anything
   under `/home/muse/crm-os/`.

## Updates
- Small updates: run `checkupdates` to see what is pending. `aether` and
  `mise-bin` style app updates are low risk.
- Full system upgrade (`sudo pacman -Syu`): only when you have a few minutes,
  save your work first, and reboot once after. The CRM restarts by itself at
  login.
- Never run a full upgrade right before an important call or demo.
