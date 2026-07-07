---
name: dispatching
description: Use when about to dispatch a subagent, pick a model tier, decide delegate-vs-DIY, or accept a subagent's result - and when a dispatched task failed and you are deciding whether to retry, escalate, or stop.
---

# Dispatch card

This card is the operative core. It usually suffices — read the full authority
(`~/claude-ops/docs/10-dispatch.md` if it exists, else `docs/10-dispatch.md` under
this plugin's root) **only** for the specific section named when a situation
exceeds the card. On any conflict: doc wins over card; the Ten Base Laws
(`skills/ten-laws`) win over both.

**Delegate if ANY** (else DIY): ≥3 full-file reads · repo-wide scan · web research
(≥2 pages) · same-pattern edits across ≥3 files · >100 lines of raw material would
enter the main conversation. DIY if: 2–3 tool calls suffice · editing 1–2
already-read files · user is asking, not tasking. (Edge cases: doc §1.)

**Every dispatch prompt has three parts** (templates: `docs/30-templates.md`):
goal+motivation · mechanically checkable acceptance criteria · report format.
Missing one → don't dispatch. Always pass an explicit `model`/tier — silent
inheritance of an expensive main model is selecting it.

**Tiers** (today's names: `BINDINGS.md` — don't hardcode from memory): cheap =
keyword locate / apply a solved pattern; standard = default workhorse (search,
implement, refactor, research, review); strong = escalation / architecture /
second opinion only. Never pick the special tier on your own initiative.

**Report contract** (paste into prompts): conclusions + `path:line` pointers only,
no raw content; >30 lines → file + 3-line summary; end with did / skipped+why /
verification level.

**Escalation ladder** (details/examples: doc §5): cheap gets 1 attempt, standard
and strong 2 each; max two tiers per task, then STOP and report. Escalate only
with the full failure trail attached. Cracked a repeatable pattern → write steps,
de-escalate for batch application. Never a third identical retry.

**Acceptance** (doc §6): never self-verify. The dispatch carries the user's
verbatim request, and the checker first re-derives "done" from it —
producer-written criteria that don't cover every clause of the request = FAIL.
Files → fresh-agent read-back (`verifier`). Code → verifier or main conversation
re-runs the test command itself; the producer's pasted transcript never counts.
Acceptance failure = a failed attempt.

**Spend gates** (doc §7, authoritative): ≥3 parallel agents or multi-round strong
→ ask the user first. Verification is never cut for savings.
