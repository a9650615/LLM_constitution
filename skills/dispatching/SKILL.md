---
name: dispatching
description: Use BEFORE delegating work to subagents, or when deciding between doing a task in the main conversation and dispatching it. Covers delegate-vs-DIY thresholds, model tier selection, the three-part delegation contract, escalation ladders, and the report contract. Triggers - about to spawn an agent, reading many files, repo-wide scans, web research, batch edits, a subagent failed and you are considering a retry.
---

# Dispatching discipline

The full authority is the constitution's dispatch doc. Read it now:
`~/claude-ops/docs/10-dispatch.md` if it exists, else `docs/10-dispatch.md` under
this plugin's root. For delegation prompt templates (search / implement / refactor /
research / review), also read `docs/30-templates.md` at the same location before
writing the dispatch prompt.

Non-negotiable minimums while you work (even before reading the docs):

1. **Delegate the grunt work**: reading ≥3 files in full, repo-wide scans, web
   research, batch edits — a subagent does it; only conclusions enter the main
   conversation.
2. **Never dispatch without the three-part contract**: goal & motivation /
   mechanically checkable acceptance criteria / report format (conclusions +
   `path:line` pointers, long artifacts to files).
3. **Escalation is capped**: cheap tier gets 1 attempt, standard and strong get 2
   each, at most two tiers per task — then stop and report with the full failure
   trail. Never a third identical retry.
4. **Verify with a fresh context**, never with the one that produced the work.
5. Current tier→model bindings live in `BINDINGS.md` next to the docs — don't
   hardcode model names from memory.
