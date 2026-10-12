# exo-watch

A small canary that tests new commits of aska-digital/exo (branch main) on this machine.

Every 10 minutes a systemd user timer runs `exo-watch`. It fetches `~/Work/exo`. If origin/main has a new
commit, it checks it out in the worktree `~/Work/exo-live`, reinstalls, then runs the root suite and each
plugin suite one at a time under `nice -n 10`. One run at a time (flock). It skips and logs if free memory
(MemAvailable) is under 1 GB, and stops if it drops under 800 MB.

- Green: exo-live stays on the new commit and one line goes to `~/Work/exo-audit/ci.log`.
- Red: exo-live goes back to the old commit, a report is written to `~/Work/exo-audit/ci/<sha>.md`, a one-line
  note goes to the bus thread `exo-ci`, and a line is typed into the tmux session `minar` if it exists.
  A red commit is not retested until main moves again.

Test switches: `EXO_WATCH_FORCE=1` runs even if nothing changed; `EXO_WATCH_FORCE_RED=1` fakes a root suite
failure and prefixes the notes with `TEST: `.

## Install (as the user, no sudo)

    install -m 755 scripts/exo-watch/exo-watch ~/.local/bin/exo-watch
    cp systemd/exo-watch.service systemd/exo-watch.timer ~/.config/systemd/user/
    systemctl --user daemon-reload && systemctl --user enable --now exo-watch.timer

Needs `gh` login, `uv`, Python 3.14, and the venv in `~/Work/exo-live/.venv`.
