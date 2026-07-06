---
description: Re-verify every claim in BINDINGS.md (the perishable layer) and update stale entries with evidence
---

BINDINGS.md is the constitution's perishable layer — model names, tool mechanics,
budget notes, local model rosters, agent wiring. It is designed to rot and be
re-verified. Do that now.

Steps:

1. Locate it: `~/claude-ops/BINDINGS.md` if it exists, else `BINDINGS.md` at this
   plugin's root. Read it in full.

2. Run its own "Quick re-verification commands" section, plus check each concrete
   claim you can test cheaply (paths exist? proxy answers? deployed agent files
   match sources? model aliases still accepted?). Also re-check the `model:` names
   declared in `agents/verifier.md` and `agents/scout.md` frontmatter, in case they
   drifted from this file's tables. For claims about the harness's current
   model/tool surface that you cannot test directly, ask the claude-code-guide agent
   rather than trusting memory.

3. Where possible, run the re-verification checks via a **dispatched subagent**;
   return conclusions only (not raw command dumps) to the main conversation.

4. For every mismatch between the file and reality: reality wins. Update the entry,
   keep the evidence (one line of actual command output) in your report. Bump the
   file's "last verified" date and its minor version. Transcribe **values only**
   (names, ports, dates, model ids) — never sentences of guidance; imperative
   guidance text added to BINDINGS.md is a read-back FAIL.

5. Do NOT touch constitution files (CLAUDE.md, docs/) from here — if a *principle*
   turned out wrong, that is an ask-the-user change, not a rebind.

6. If the file lives in a git repo, commit (and push if pre-authorized). Report:
   entries confirmed / entries updated (with evidence) / entries you could not
   verify and why.
