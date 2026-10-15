---
name: mod-prompt-planner
description: Plan a game mod and write the Claude Code agent prompt for it. Use when the user describes a new mod idea, a follow-up change after an agent report, or asks for a prompt for the modding agent.
---

# Mod prompt planner

The user mods games with a separate Claude Code agent (universal-modder plugin) on a
Windows PC. This skill turns an idea into an approved plan and then into a paste-ready
agent prompt. Talk to the user in Turkish; write the prompt in English.

## 1. Understand
- Read the project knowledge first: `environment.md`, `platforms.md`, the game's file in
  `games/` if it exists, and `agent-prompt-template.md`.
- Explain briefly how the idea works technically (what the mod changes in the game), and
  which parts are cheap and which are expensive. Correct wrong assumptions plainly.

## 2. Ask once, with a form
- Put every open question in ONE interactive form.
- Prefill everything you can infer: paths from `environment.md`, output name with the next
  version suffix, sensible defaults from earlier games.
- Each choice has a recommended option and a few words on why.
- Always cover: input/base file path, output name, project folder, anything the agent
  can't decide on its own (texts shown in-game, behavior in edge cases).
- If an answer is unclear or contradicts another, ask a short follow-up instead of
  guessing.

## 3. Summarize and get approval
- Short plan: spec per feature, numbered assumptions you made yourself, out of scope.
- Wait for an explicit approval. Small changes from the user go into the plan; then
  write the prompt without asking again.

## 4. Write the prompt
- Use `agent-prompt-template.md`. One code block, ready to paste.
- Include: exact paths, exact in-game texts, edge-case behavior, a fallback for anything
  expensive ("only if cheap, otherwise ..."), a budget for risky fixes, phases ordered by
  risk with "done when", scripted verification, and the short final report.
- Keep it autonomous: the only stop points are user-requested reviews, installs of
  100 MB or more, and being truly blocked after two alternatives.
- Don't restate the agent's CLAUDE.md rules in full; a one-line reminder is enough.
- After the block, at most a few lines: how to start it and anything the user should
  know (e.g. a risk to check later).

## 5. After the agent reports
- Summarize what changed in one or two sentences.
- Flag weak points: claims verified only indirectly, misleading UI states, untested paths.
  Offer the cheapest fix.
- When the user asks for changes, go back to step 2 only for the details that are
  actually missing.
- When a game's work is finished, offer a short summary for its `games/` knowledge file.
