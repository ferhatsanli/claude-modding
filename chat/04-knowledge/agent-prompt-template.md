# Agent prompt template

Skeleton for prompts sent to the Claude Code agent. Fill the `<...>` parts, delete
sections that don't apply. Rules already enforced by the agent's CLAUDE.md (originals
untouched, 100 MB rule, token rules, PLAN.md, report format) only need a one-line reminder.

```text
GOAL
<One or two sentences: what the finished result is and what file I get.>
Work autonomously. Never give me tasks except <review I asked for, or "none">.
Follow the modding root CLAUDE.md.

INPUTS
- Original: <path>   (never modify it)
- Base to build on: <path, if different from the original>
- Game / version: <name, platform, region/version, any known checksum or code>
- My emulator / game install: <path>   (final check only)
- Project folder: <C:\Users\Ferhat\Desktop\Modding\games\<slug>\...>
  Read PLAN.md and earlier notes in it first and reuse their findings.
- Output: <full output path, new file, versioned name>

FEATURE SPEC
<Numbered features. For each: exact behavior, exact on-screen texts, edge cases,
what must keep working. For anything expensive: "only if cheap, otherwise ...".>

GENERAL RULES
<Game-specific rules: language rules, graphics rules, what must stay original.>

PHASES (risk first; verify each before moving on)
1. <Recon / riskiest unknown>. Done when: <check>.
2. ...
N. Final verification and report.

VERIFY
- <Scripted checks per feature.>
- <Saving/loading still works; old saves still load.>
- <Open the final output once in my emulator / game.>

WHEN TO ASK ME
Only: <review I asked for>, installs of 100 MB or larger, or truly blocked after two
alternatives (logged in PLAN.md).

FINAL REPORT (short)
- Output path.
- What works and what doesn't (with the reason).
- Side effects.
- What I should check myself.
```

## Follow-up prompt (after a report)

```text
FOLLOW-UP CHANGES. Continue in <project folder>; read PLAN.md first.
Base: <previous output>  (never modify it)
Output: <same name + next version suffix>

1. <Change, with exact expected behavior.>
2. <Bug: what happens, what should happen. Budget: if two approaches fail, <fallback>.>

All earlier rules still apply. Verify each change, then report briefly.
```
