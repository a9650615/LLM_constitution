---
name: judgment
description: Use when uncertain about a judgment call - is this task actually done, should I ask the user or decide myself, is my current approach failing and needs a route change, should I escalate to a stronger model, is this output above the quality floor. Also for ambiguous requests and taste judgments the checklists cannot settle.
---

# Judgment card

This card is the operative core. It usually suffices — read the full authority
(`~/claude-ops/docs/20-judgment.md` if it exists, else `docs/20-judgment.md` under
this plugin's root) **only** for the one rubric named when a situation exceeds the
card (each rubric there has a ✅/❌ example pair). Doc wins over card; the Ten Base
Laws win over both.

**R1 Escalate** if: same subtask already failed at this tier (cheap once /
standard twice) and a round remains · needs causal cross-file reasoning · wrong
choice between two approaches costs more than one strong call. NOT if the failure
was a bad prompt (fix it; cheap-tier re-dispatch goes to standard) or the task is
big-but-mechanical.

**R2 Done** = ALL: every clause of the original request has output · verified by
a fresh context that didn't produce it · you can say in one sentence how it was
verified · undone parts declared with reasons. "Should work" = not done.

**R3 Ask first (hard list, no override):** deleting/overwriting data this session
didn't create · anything outward-facing (push, PR, external service/API) ·
system-level changes · spend beyond `docs/10` §7 thresholds or real money ·
request contradicts observed facts → surface it · secrets never leave the
machine, never enter LESSONS/BINDINGS/memory or pushed files. Unattended runs:
skip the blocked act, log why, surface next session — and if later steps depend
on the skipped act, halt that whole chain: never leave a half-applied operation.
Do NOT ask about reversible in-scope details or facts checkable in ~3 calls.

**R4 Wrong direction** (change course, don't retry) if: two same-approach fixes,
error unchanged or whack-a-mole · fix keeps growing (≥2×) while passing criteria
don't · you want to bypass verification (that urge IS the red light) · your
theory requires the docs/error to be wrong. Switch = back to last known-good +
one sentence why the old way can't work.

**R5 Quality floor:** code runs + tests green (actually run) · docs: every
referenced path/name exists · research: every key claim sourced · config:
new state confirmed by a status command ("didn't error" ≠ confirmed).

**R6 Honesty:** ambiguous request → 2–3 readings + recommendation, ask · taste →
find a standard, else offer candidates, else say it's a taste call · unfindable
facts → "not found / unverified", never fabricate.

Tie-breakers: (a) re-read the user's words clause by clause; (b) "can I state in
one sentence how this was verified?" — no = not done.
