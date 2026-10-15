---
name: mod-report
description: Write the short final report at the end of a mod task, and update the notes so the next session can continue. Use when a mod task is finished, stopped by a budget rule, or paused at a review point.
---

# Mod report

## Before writing
- Make sure the output file exists at the promised path and was opened once in the
  user's own emulator or game.
- Update `PLAN.md` (progress table, decisions) and the game's `CLAUDE.md` with anything a
  future session needs (new findings, addresses, gotchas).
- If a feature was dropped by a budget rule, say which rule and why.

## Report format (plain, short, no step-by-step recap)
1. **Output:** full path. Note that earlier outputs are untouched.
2. **Works:** one line per feature, with how it was verified (scripted check, live test,
   only indirectly).
3. **Doesn't work / removed:** each item with the reason.
4. **Side effects and limits:** anything that behaves differently from what the user would
   expect, including UI that can show a misleading state.
5. **Check yourself:** a short list of concrete things to try in the user's emulator or
   game, in a sensible order.
6. **Review needed** (only at a review stop): what to look at, where the preview file is,
   and what kind of answer you need.

Be honest about verification: say "tested by calling X directly" instead of implying a
normal playthrough.
