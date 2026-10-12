# Jarvis: Shahid's voice assistant on charminar

Hold **Caps Lock** (or F9), speak, let go. Jarvis shows what it heard, does
the thing or answers, and speaks the reply. **Super+J** opens the same
assistant as a typed chat in its own window (workspace 6).

Everything runs as Shahid and nothing needs sudo. In normal use Jarvis acts on
the machine through the `jarvis-do` command, a fixed list of safe actions, and
Bash is limited to it. It is not the only way, though: in design (FreeCAD) mode
the model also has the FreeCAD MCP tools, and see Safety below for what that
means.

## Pieces

| File | What it does |
|------|--------------|
| `bin/jarvis-ptt` | Push-to-talk: start/stop the microphone recording, beeps, on-screen "Listening…" and "Thinking…". Bound to Caps Lock (Menu keysym) and F9. |
| `bin/jarvis-ask` | Transcribes the recording, tries the fast path, otherwise asks Claude. Shows the reply as a notification and speaks it. |
| `bin/jarvis-intent` | Fast path: "open whatsapp", "volume up", "lock", "what time is it" and the like run instantly without the model. |
| `bin/jarvis-do` | The action list (apps, CRM read-only queries, reminders, volume, brightness, keyboard language, screenshot, type text, lock, system menu). `jarvis-do help` lists them. |
| `bin/jarvis-say` | Text to speech. Online neural voices (English, Urdu, Arabic) through edge-tts; local Piper voices (English, Arabic) when offline. |
| `bin/jarvis-chat` | Opens Claude Code interactively in a `jarvis` window with the same prompt and the same `jarvis-do` hands. |
| `prompt.md` | Who Jarvis is, how to answer, what it may do. `prompt-voice.md` adds the JSON reply format used in voice mode. |
| `session-CLAUDE.example.md` | Template for the standing context. `install.sh` copies it to `~/.local/share/jarvis/session/CLAUDE.md` only if that file does not exist yet, and never overwrites it. The real file (who the owner is, territory, how they phrase requests) stays private on the machine and is not in the repo. Every Jarvis session (voice, chat, phone) loads it. |
| `jarvis-remote`, `jarvis-remote.service` | The standing Remote Control session for the phone app (see `phone.md`). |
| `voxtype.toml` | Speech recognition settings: Whisper base (multilingual, auto language). |
| `install.sh` | Puts it all in place: symlinks in ~/.local/bin, Python venv (uv) with piper-tts and edge-tts, voice models, Whisper model, beeps. |

## How a request flows

1. Caps Lock down: `jarvis-ptt start` records 16 kHz mono from the default microphone to `$XDG_RUNTIME_DIR/jarvis/rec.wav`.
2. Caps Lock up: `jarvis-ptt stop` ends the recording and runs `jarvis-ask --audio` in the background.
3. `voxtype transcribe` (Whisper base) turns speech into text. About 1.5x real time on this CPU: a five-second request takes about eight seconds.
4. `jarvis-intent` handles everyday commands at once. Everything else goes to `claude -p` (Sonnet, Haiku as fallback) with the Jarvis prompt, `jarvis-do` as the only allowed Bash command, Read limited to the Jarvis runtime directory (for screenshots), and web search. One Claude session per day is reused, so follow-up questions keep their context.
5. The reply is shown as a notification and spoken by `jarvis-say`. Log: `~/.local/state/jarvis/log.jsonl`.

Typical timings on charminar: fast path about 7 seconds end to end (mostly transcription), Claude path 15 to 25 seconds.

## Keys

| Key | Action |
|-----|--------|
| Caps Lock (hold) or F9 (hold) | Talk to Jarvis |
| Super+J | Jarvis typed chat |
| Super+Shift+J | Stop Jarvis (cancel recording or speech) |

Caps Lock no longer toggles capitals (`caps:menu` in `hyprland/simple-input.lua`); Shift gives capitals as usual.

## Safety

- `jarvis-do` is the whole surface for Bash. Adding an action means adding a case there.
- In design (FreeCAD) mode the model also has the FreeCAD MCP tools. Its `execute_code` tool runs arbitrary Python as the desktop user, and the ban on the Write and Edit tools does not contain it. This applies to the voice and typed sessions on the laptop; the phone session has no FreeCAD tools (see `phone.md`). The trust boundary is therefore the desktop user account, not the `jarvis-do` list. The prompt tells the model to use `execute_code` only for building and saving parts, but that is an instruction, not a sandbox.
- Shutting down, restarting and logging out are not actions: Jarvis opens the system menu and Shahid picks.
- CRM access is read-only over the local HTTP API; the server and `/home/muse` are never touched.
- No session data leaves the machine except the request to Claude (Shahid's own account) and the text sent to the online voice service.
