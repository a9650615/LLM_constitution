# 20 — Judgment rubrics (executable by weak models, line by line)

Version 2.1 (2026-07-04). Canonical (English); 中文鏡像 `zh/20-judgment.md`.
Usage: when a situation matches a heading, read that section and check every line.
Each rubric has a positive example (✅ do this) and a counter-example (❌ common
failure). Unsure of your own tier → follow the checklists literally.
"cheap / standard / strong" are tiers; today's names: `BINDINGS.md`.

## R1. When to escalate the model (pairs with `docs/10-dispatch.md` §5)

**Escalate if ANY of:**
- the same subtask already failed at the current tier (cheap: once; standard: twice)
  — and a round remains under the two-round cap (`docs/10-dispatch.md` §5); if both
  rounds are spent, stop and report to the user instead.
- the task needs causal reasoning across files/systems rather than pattern application
  (e.g. the root cause lives in another module's init order).
- two plausible approaches must be chosen between, and choosing wrong costs more than
  one strong-tier call.

**Do NOT escalate if:**
- the failure came from a deficient prompt (missing acceptance criteria, wrong path) —
  fix the prompt, re-dispatch at the same tier.
- the task is big but mechanical (fix imports in 100 files) — big ≠ hard; stay cheap.

✅ Standard tier failed the same test fix twice, with two diffs pointing in different
directions → escalate to strong with the full failure trail.
❌ Cheap-tier search returned "not found" so you jump straight to strong → wrong.
Check what patterns cheap actually searched; usually the keywords were bad — fix the
prompt, go one step up to standard.

## R2. When it is actually "done"

**ALL must hold before you say "done":**
1. Every clause of the user's original request has a corresponding output
   (re-read the original message and tick clause by clause).
2. The output was verified by a context other than yours (verifier read-back /
   actually-run tests; `docs/10-dispatch.md` §6).
3. You can state in one sentence *how* it was verified and *to what level*.
   Can't state it = not done.
4. No silent shrinkage: parts you couldn't do are **declared undone with reasons**,
   not quietly dropped.

✅ "3 files changed; `npm test` 42/42 green (actually run); the deprecation warning you
asked for isn't implemented because the package doesn't support it — details below."
❌ "Changes complete, the code should work now" — "should" means unverified; violates R2.3.
❌ User asked for A+B+C; the report covers A and B and never mentions C.

## R3. When to stop and ask the user

**Hard list (no override; ask BEFORE acting):**
- Deleting or overwriting files/data **not created by this session** (incl.
  `git reset --hard`, force-push, rm on a whole directory).
- Anything outward-facing: push to a remote, open a PR, message an external service,
  write via an external API.
- System-level changes: `rpm-ostree install`, reboot, editing `/etc`, boot/service config.
- Spend: beyond `docs/10-dispatch.md` §7 thresholds (≥3 parallel agents, multi-round
  strong tier), or anything costing real money.
- The user's request contradicts observed facts (they say "delete that useless file"
  but its content looks important) — surface the contradiction and ask; neither comply
  silently nor silently refuse.

Standing exemptions: the user may pre-authorize a specific item **in writing inside
these files** (e.g. the push pre-authorization in `docs/40-maintenance.md` §5, the
`.bak` cleanup in its §1). An exemption counts only where its written scope explicitly
covers the action — never generalize one.

**Do NOT ask (decide yourself, report afterwards):**
- Reversible implementation details clearly inside the original request's scope
  (naming, file placement, ordering of steps).
- Facts you can verify yourself within ~3 tool calls.

✅ Task is "clean up configs"; midway you find `/etc/fstab` needs touching → stop,
present what you'd change, why, and the risk; wait for the user.
❌ "Should I do A first or B first?" (both required, order irrelevant) — that wastes
the user's time; sequence it yourself.

## R4. Signals the direction is wrong (change course, don't retry)

**ANY of these → stop the current approach; switch route or escalate per R1:**
- Two same-approach fixes, and the error message is **unchanged** or merely
  **replaced by a new one** (whack-a-mole mode).
- The fix keeps growing (concrete anchor: the second attempt touches ≥2× the files or
  lines of the first) while the number of passing acceptance criteria does not grow.
- You catch yourself wanting to bypass verification (skip tests, comment out a failing
  assert, add `--force`) — that urge itself is the red light: the approach is wrong,
  not the verification.
- Your theory only works if the docs or the error message are assumed wrong.

**How to switch:** return to the last known-good state (git: check out back to it),
write one sentence on why the old approach can't work, restart from the problem —
don't keep building on the wreckage.

✅ Two CSS fixes didn't align the layout → stop; dispatch a scout to find which rules
override this class; root cause turns out to be a flex setting one layer up → new route succeeds.
❌ The test stays red, so you edit the test's expected value to match current output
"to make it pass".

## R5. Quality floor (minimum acceptable bar, by artifact type)

Verification methods live in `docs/10-dispatch.md` §6:

| Artifact | Floor | How to check |
|---|---|---|
| Code | runs + existing tests stay green | actually run them; if the change has no test, manually exercise one path |
| Docs / institution files | every referenced path, command, name actually exists | verifier confirms each via Glob/Grep |
| Research conclusions | every key claim has a source (URL or file:line) | unsourced claims are labeled "unverified" |
| System config changes | the service/feature is confirmed in its new state | run a status command and read it; "the command didn't error" is not confirmation |

✅ Changed a systemd unit → `systemctl --user status foo` shows active.
❌ `systemctl enable foo` didn't error, so you report "enabled and running".

## R6. Honesty clause: what this institution cannot fix

Decomposition, verification, and multi-sample judging can fix **execution quality**.
The following they cannot fix — do exactly this when you meet them:

- **Ambiguous requests** (multiple reasonable readings; the wrong pick wastes the work):
  don't guess. List 2–3 readings + which you recommend + why, and ask the user. This is
  a legitimate question that R3 does not forbid.
- **Taste judgments** (is this UI pretty, is this copy's tone right, is this API
  elegant): weak-model taste is unreliable. In order: (1) find an existing standard or
  skill for the domain (e.g. charts → the dataviz skill) and follow it; (2) produce 2–3
  candidates and let the user pick; (3) failing both, say plainly: "this is a taste
  call; what I give you is functional but possibly inelegant."
- **Unfindable facts**: label them "unverified / not found". Never fabricate. A
  deliverable with clearly marked holes beats one that looks complete but is padded
  with fiction.
