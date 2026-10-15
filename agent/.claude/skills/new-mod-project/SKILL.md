---
name: new-mod-project
description: Set up the folder, notes and safe working copies for a new game or a new mod task under games\. Use at the start of work on a game that has no folder yet, or when a prompt starts a new task for an existing game.
---

# New mod project

1. Pick a slug from the game name: lowercase, hyphens, platform suffix
   (e.g. `harry-potter-sorcerers-stone-gba`, `skyrim-se-pc`).
2. Create `games\<slug>\` with:
   - `CLAUDE.md` from `templates\GAME-CLAUDE.md` (game facts that every later session
     needs: version, paths, engine, tools, gotchas). Fill what you know; keep it short.
   - `original\` — a read-only copy of the original file(s) if the original is a single
     file such as a ROM or archive. For installed PC games, don't copy the game; record
     its install path and version instead.
   - `work\` — scripts and intermediate files.
   - `output\` — finished results only.
   - `tools\` — tools installed for this game.
3. For a new task inside an existing game folder, create `games\<slug>\<task-slug>\` with
   its own `PLAN.md`, and keep shared scripts in the game's `work\`.
4. Create `PLAN.md` from `templates\PLAN.md` and fill the phases from the prompt.
5. Verify the original: checksum (SHA-1, CRC32) or game build, and record it in the
   game's `CLAUDE.md`. Compare the working copy's hash with the original's.
6. Search prior art: `um kb search "<game>"`, then a short web search for existing
   decomps, tools and mods for this exact version. Record useful links in the game's
   `CLAUDE.md`.
7. For PC games, run `um scan` and back up the save folder with `um backup` before any
   test run.
