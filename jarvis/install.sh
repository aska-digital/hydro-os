#!/bin/bash
# Install or update Jarvis for Shahid. Re-runnable. Run as Shahid, no sudo.
# Puts the scripts on the PATH, builds the Python environment for the voices,
# downloads the voice and speech-recognition models, and generates the beeps.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
J="$HOME/.local/share/jarvis"
BIN="$HOME/.local/bin"
mkdir -p "$J" "$J/session" "$J/sounds" "$J/voices" "$BIN" "$HOME/.local/state/jarvis"

echo "scripts..."
for s in "$HERE"/bin/jarvis-*; do
  ln -sf "$s" "$BIN/$(basename "$s")"
  chmod +x "$s"
done
cp "$HERE/prompt.md" "$HERE/prompt-voice.md" "$HERE/voxtype.toml" "$J/"
# Standing context about the owner. The real file is private to this machine: copy the template only if none exists, never overwrite.
if [ ! -e "$J/session/CLAUDE.md" ]; then
  cp "$HERE/session-CLAUDE.example.md" "$J/session/CLAUDE.md"
  echo "Fill in $J/session/CLAUDE.md (about the owner; template copied, replace the <placeholders>)."
fi
mkdir -p "$HOME/.config/systemd/user" && cp "$HERE/jarvis-remote.service" "$HOME/.config/systemd/user/" && systemctl --user daemon-reload 2>/dev/null || true

echo "python environment (uv)..."
UV=$(command -v uv || ls "$HOME"/.local/share/mise/installs/uv/*/.mise-bins/uv 2>/dev/null | head -1)
[ -x "$J/venv/bin/python" ] || "$UV" venv --python 3.12 "$J/venv" >/dev/null
"$UV" pip install --python "$J/venv/bin/python" -q piper-tts edge-tts

echo "voices (piper, offline fallback)..."
for v in en_US-lessac-medium ar_JO-kareem-medium; do
  [ -f "$J/voices/$v.onnx" ] || "$J/venv/bin/python" -m piper.download_voices --data-dir "$J/voices" "$v" >/dev/null 2>&1
done

echo "speech recognition model (whisper base, multilingual)..."
M="$HOME/.local/share/voxtype/models"; mkdir -p "$M"
[ -f "$M/ggml-base.bin" ] || curl -fsSL -o "$M/ggml-base.bin" "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin"

echo "beeps..."
python3 -I - "$J/sounds" <<'EOF'
import math, struct, sys, wave
d = sys.argv[1]
def tone(path, freqs, ms=90, rate=16000, vol=0.25):
    frames = bytearray()
    for f in freqs:
        n = int(rate * ms / 1000)
        for i in range(n):
            env = min(1.0, i / (rate * 0.01), (n - i) / (rate * 0.01))
            frames += struct.pack("<h", int(vol * env * 32767 * math.sin(2 * math.pi * f * i / rate)))
    with wave.open(path, "wb") as w:
        w.setnchannels(1); w.setsampwidth(2); w.setframerate(rate); w.writeframes(bytes(frames))
tone(f"{d}/start.wav", [660, 880])
tone(f"{d}/stop.wav", [880, 660])
EOF

echo "jarvis installed. Talk key: hold Caps Lock (or F9). Typed chat: Super+J."
