#!/bin/bash
# Install the web apps Shahid uses, with explicit icon URLs (Omarchy 4.0.4
# cannot fetch relative favicons). Re-runnable. Run as Shahid, no sudo.
set -e
omarchy webapp install "WhatsApp"     "https://web.whatsapp.com/"  "https://web.whatsapp.com/apple-touch-icon.png"
omarchy webapp install "Gmail"        "https://mail.google.com"    "https://www.gstatic.com/images/branding/product/1x/gmail_2020q4_512dp.png"
omarchy webapp install "Google Drive" "https://drive.google.com"   "https://www.gstatic.com/images/branding/product/1x/drive_2020q4_512dp.png"
omarchy webapp install "Google Meet"  "https://meet.google.com"    "https://www.gstatic.com/images/branding/product/1x/meet_2020q4_512dp.png"
echo "web apps installed; launchers in ~/.local/share/applications"
