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
cp "$HERE/session-CLAUDE.md" "$J/session/CLAUDE.md"   # standing context: who Shahid is, how he asks
mkdir -p "$HOME/.config/systemd/user" && cp "$HERE/jarvis-remote.service" "$HOME/.config/systemd/user/" && systemctl --user daemon-reload 2>/dev/null || true

echo "python environment (uv)..."
UV=$(command -v uv || ls "$HOME"/.local/share/mise/installs/uv/*/.mise-bins/uv 2>/dev/null | head -1)
[ -x "$J/venv/bin/python" ] || "$UV" venv --python 3.12 "$J/venv" >/dev/null
# Pinned versions (onnxruntime comes with piper-tts; pinned too).
"$UV" pip install --python "$J/venv/bin/python" -q piper-tts==1.8.0 edge-tts==7.2.8 onnxruntime==1.31.0

# check_sha256 FILE HASH: on a mismatch, delete the file and stop.
check_sha256() {
  local got
  got=$(sha256sum "$1" | cut -d' ' -f1)
  if [ "$got" != "$2" ]; then
    rm -f "$1"
    echo "ERROR: sha256 mismatch for $1" >&2
    echo "  expected $2" >&2
    echo "  got      $got" >&2
    echo "  The file was deleted. Re-run install.sh to download it again." >&2
    exit 1
  fi
}

echo "voices (piper, offline fallback)..."
declare -A VOICE_SHA=(
  [en_US-lessac-medium]=5efe09e69902187827af646e1a6e9d269dee769f9877d17b16b1b46eeaaf019f
  [ar_JO-kareem-medium]=9e95cab07b679da603bba17c4dec7ab3111320571964ee95c0379603c086491e
)
for v in en_US-lessac-medium ar_JO-kareem-medium; do
  [ -f "$J/voices/$v.onnx" ] || "$J/venv/bin/python" -m piper.download_voices --data-dir "$J/voices" "$v" >/dev/null 2>&1
  [ -f "$J/voices/$v.onnx" ] || { echo "ERROR: voice $v did not download" >&2; exit 1; }
  check_sha256 "$J/voices/$v.onnx" "${VOICE_SHA[$v]}"
done

echo "speech recognition model (whisper base, multilingual)..."
M="$HOME/.local/share/voxtype/models"; mkdir -p "$M"
[ -f "$M/ggml-base.bin" ] || curl -fsSL -o "$M/ggml-base.bin" "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin"
check_sha256 "$M/ggml-base.bin" 60ed5bc3dd14eea856493d334349b405782ddcaf0028d4b5df4088345fba2efe

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
