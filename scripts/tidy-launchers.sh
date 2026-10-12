#!/bin/bash
# Tidy the app menu for Shahid. Re-runnable. Run as Shahid, no sudo.
# 1. Remove web app launchers he does not use (reinstall with omarchy webapp install).
# 2. Hide developer and system tools from the app menu (the programs stay
#    installed; a user override file with Hidden=true just removes the menu row).
# 3. Make Gmail the handler for mailto: links.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
APPS="$HOME/.local/share/applications"
mkdir -p "$APPS" "$HOME/.local/bin"

for w in Basecamp Discord HEY X; do
  [ -f "$APPS/$w.desktop" ] && omarchy webapp remove "$w" >/dev/null && echo "removed web app: $w"
done

HIDE="aether avahi-discover bssh btop btrfs-assistant bvnc cliamp com.moonlight_stream.Moonlight
com.obsproject.Studio cups dev.tensaku.Tensaku fcitx5-configtool org.fcitx.Fcitx5 footclient foot-server
gcr-prompter gcr-viewer gnome-disk-image-mounter gnome-disk-image-writer imv-dir io.missioncenter.MissionCenter
lstopo nvim nvtop omacut omawrite org.gnome.DiskUtility org.kde.kdenlive org.keepassxc.KeePassXC qv4l2 qvidcap
uuctl voxtype-configure limine-snapper-restore obsidian"
for id in $HIDE; do
  src="/usr/share/applications/$id.desktop"
  [ -f "$src" ] || continue
  name=$(sed -n 's/^Name=//p' "$src" | head -1)
  printf '[Desktop Entry]\nType=Application\nName=%s\nHidden=true\nNoDisplay=true\n' "$name" > "$APPS/$id.desktop"
done
# Omarchy's own user launchers for tools he does not need: hide, do not delete.
for id in Docker "Disk Usage"; do
  f="$APPS/$id.desktop"
  [ -f "$f" ] && ! grep -q '^NoDisplay=true' "$f" && printf 'NoDisplay=true\n' >> "$f"
done

install -m 755 "$HERE/gmail-mailto" "$HOME/.local/bin/gmail-mailto"
install -m 755 "$HERE/minar-desk" "$HOME/.local/bin/minar-desk"
install -m 644 "$HERE/../launchers/gmail-mailto.desktop" "$APPS/gmail-mailto.desktop"
xdg-mime default gmail-mailto.desktop x-scheme-handler/mailto
update-desktop-database "$APPS" 2>/dev/null || true
echo "mailto handler: $(xdg-mime query default x-scheme-handler/mailto)"
