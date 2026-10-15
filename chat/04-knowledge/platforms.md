# Platform notes

Short, practical notes per platform. Add to them when a project teaches something new.

## Game Boy Advance (ROM hacking)
- Work on a copy of the .gba extracted from the zip; the original zip stays untouched.
- Deliver a ready-to-play patched ROM (VisualBoyAdvance opens it directly). A BPS patch
  is optional and only if it costs nothing.
- Identify the exact version first (header game code, CRC32/SHA-1). Codes, decomps and
  guides are version-specific; a "collection" re-release is a different build.
- Text is often custom-encoded or compressed. Fastest route to the format: run the game
  in mGBA with a Lua script, dump RAM while a known line is on screen, trace it back to
  the ROM. Static disassembly alone is much slower.
- The agent drives mGBA itself with Lua (input, RAM dumps, breakpoints, screenshots).
- New features go in as small hooks into free ROM space; state in free RAM.
- GameShark / CodeBreaker / Action Replay codes can be built into the ROM as per-frame
  writes in the main loop, toggled from a menu. Most are encrypted; the agent can decrypt
  them. "Master/enable" codes are only for the cheat device and are skipped.
- Cheats that write game data (unlock all, max points) can't be undone by turning them
  off. Make them one-shot actions with an honest label instead of a fake toggle.
- In-ROM Turkish: ASCII only, no font changes.

## PC (Windows) games, e.g. Skyrim
- No emulator: the agent works with the installed game, the game's own modding tools and
  community frameworks. Prefer the established route for the game (for Skyrim: the
  Creation Kit, SKSE, a mod manager, Papyrus scripts) and package the result as a mod
  that can be enabled and removed cleanly.
- Never modify the game's own files in place. Mods go in their own folder or through a
  mod manager, so uninstalling restores the original game.
- Back up saves before testing; test on a new save when possible.
- No online/anti-cheat games and no bypassing DRM or ownership checks.
- Record the exact game version and runtime (e.g. Skyrim SE vs AE, game build number);
  plugins and script extenders are version-specific.
