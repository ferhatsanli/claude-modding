# My modding environment

Keep this file current. Update it whenever a tool is installed, moved or removed.

## Machines
- Main modding machine: Windows gaming laptop. User folder: `C:\Users\Ferhat`.
  PC games and Windows-only tools run only here.
- Also used, with the same agent setup (`setup-mac.sh`, `setup-linux.sh`,
  `setup-android.sh` in the repo's `agent/` folder, root `~/Modding`):
  - MacBook Pro (macOS, main computer)
  - Fedora Linux
  - Android phone, in Termux
  These are fine for emulator work, text/translation work, scripts and notes. When a
  prompt is for one of them, name the device so paths and tools match.
- I live in the Netherlands (timezone Europe/Amsterdam).

## Claude Code (on the Windows laptop)
- Claude Code CLI, started from a terminal inside the modding root.
- Plugin: universal-modder (rehan-remade/universal-modder), installed via
  `/plugin marketplace add rehan-remade/universal-modder` and
  `/plugin install universal-modder@universal-modder`. Provides the mod skills and the
  `um` CLI.
- Installed with winget: Git, Python 3.12, ffmpeg, uv.
- Auto-compact threshold: `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=65` set with `setx`
  (settings.json is not reliable for this).
- I usually run the agent in auto mode with full permissions inside the project folder.
- Agent rules live in the modding root's `CLAUDE.md` (from the `agent/` folder of the
  claude-modding repo).

## Folders
- Modding root (agent setup): `C:\Users\Ferhat\Desktop\Modding`
  - one subfolder per game, e.g. `games\<game-slug>\`
- Existing GBA work (before the modding root existed):
  `C:\Users\Ferhat\Desktop\Gameboy Advance\`
  - `ROM\` — original ROMs (zip). Never modified.
  - `VisualBoyAdvance.exe` — my emulator for playing.
  - `work\` — agent work folder: mGBA 0.10.5 portable (`work\mgba\`), translation
    scripts, `MODLOG.md`, `cheats\` (PLAN.md, CODES.md, icons), `output\` (finished ROMs).

## Emulators and tools
- VisualBoyAdvance: what I play on. No debugger or scripting. Can't take a ROM path with
  spaces on the command line; open ROMs via File > Open.
- mGBA 0.10.5 (portable, in `work\mgba\`): the agent's test emulator, with Lua scripting
  and debugger.

## Games I own / plan to mod
- Harry Potter and the Sorcerer's Stone (GBA, USA). Done: Turkish translation, cheats menu.
- The Elder Scrolls V: Skyrim (PC, Windows). Next.
