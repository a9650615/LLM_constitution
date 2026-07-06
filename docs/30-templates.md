# 30 — Delegation prompt templates

Version 2.1 (2026-07-06). Canonical (English); 中文鏡像 `zh/30-templates.md`.
Usage: first confirm delegation is warranted (`docs/10-dispatch.md` §1) and pick the
subagent type + tier (§3), then copy the matching template and fill the `{…}` blanks.
Paste the whole block into the Agent tool `prompt` param. Each template already embeds
the three-part contract (goal & motivation / acceptance criteria / report format) —
do not delete sections. Tier→model bindings: `BINDINGS.md`.

Rules common to all templates:
- Long artifacts go to files, report the path (temp → scratchpad; keepers → `{project dir}`).
- Every report ends with: did / skipped + why / verification level.
- Always pass an explicit `model`/tier on every dispatch — silent inheritance of a
  premium main-session model is selecting it (Law 8, `docs/05-ten-laws.md`).
- A producing agent's pasted test output is a claim, not acceptance: the verifier or
  the main conversation must re-run the test command itself (`docs/10-dispatch.md` §6).

---

## T1. Search / locate (type: `scout`, cheap tier; semantic search → `Explore`, standard)

```
[Goal] In {directory or repo path}, find {the thing}.
[Motivation] I will next {why it matters}, so what counts is {location / usage / every occurrence}.
[Scope] Search only {dirs}. Known leads: {keywords, filename patterns, related terms}.
[Acceptance criteria]
- Every hit comes with file path:line.
- If nothing is found, list the patterns and directories you tried
  (≥3 variants: case, synonyms, spelling).
[Report format] Hit list, one per line: path:line + one-sentence description.
≤15 lines total. Do not paste source content.
```

## T2. Implement (type: `general-purpose`, standard tier)

```
[Goal] In {project path}, implement {feature description}.
[Motivation] {who uses this, what problem it solves} — judge edge cases against this.
[Current state] Relevant files: {paths + one sentence each}. Existing conventions: {naming/tests/style}.
[Scope] Touch ONLY these files: {list}. If another file needs changing, stop and
report — do not touch it.
[Acceptance criteria]
- {concrete behavior: input X yields Y}
- `{test command}` fully green (actually run, not inferred).
- Style matches surrounding code (comment density, naming conventions).
[Report format] Files changed (path:line ranges), last 5 lines of test output,
skipped + why, verification level. ≤20 lines.
```

## T3. Refactor (type: `general-purpose`, standard tier)

```
[Goal] Refactor {scope} from {current shape} to {target shape}.
[Motivation] {why this is worth doing}.
[Iron rule] Refactor = behavior unchanged. Any externally visible behavior change is a
bug. Problems you feel like "fixing while here": report them, don't fix them.
[Scope] Touch only: {file list}.
[Acceptance criteria]
- Run `{test command}` BEFORE starting and record the baseline (passed/skipped counts);
  after refactoring, results must be identical.
- For parts without test coverage: list which changes are unprotected, note the risk.
[Report format] Baseline vs post-refactor test results (side by side), change list
(path + one sentence), list of unprotected changes. ≤20 lines.
```

## T4. Research (type: `general-purpose` or `Explore`, standard tier)

```
[Goal] Answer: {concrete question}.
[Motivation] The answer feeds {which decision}, so go deep on {decision-relevant
aspects} and skip the rest.
[Source requirements] Prefer {official docs / repo source / named sites}. Every key
claim carries a source (URL or file:line). Unfindable → mark "unverified"; no
speculation to fill holes.
[Acceptance criteria]
- The first paragraph IS the answer (no background windup).
- If the answer is "it depends", list the branches + the condition for each.
[Report format] Full report written to {file path}; the reply gives only: answer
summary ≤5 lines + report path + confidence (high/medium/low + why).
```

## T5. Review / acceptance (type: `verifier`; code review may also use `general-purpose`, standard)

```
[Goal] Accept/reject {artifact description} against the criteria below, item by item.
[Background] You get the requirements only, not the production process — judge
independently from files and actual runs.
Original request, verbatim: {paste the user's words}.
[Objects] {file paths / diff range / commands}.
[Acceptance criteria]
1. {criterion 1, mechanically checkable}
2. {criterion 2}
3. Every referenced path/command/name actually exists (verify via Glob/Grep).
[Report format] Line 1: overall verdict (pass / fail). One line per criterion:
verdict + evidence (file:line or key output line). "Unverifiable" items listed
separately + what would be needed. Describe problems only — do NOT fix anything.
```

---

## Pre-dispatch self-check (common failures)

- ❌ Acceptance criteria like "good quality", "works correctly" — not mechanically
  checkable, same as writing nothing.
- ❌ No scope given; the agent refactors half the repo as a side effect.
- ❌ Forgot to specify "what to report when not found / not doable"; the agent
  fabricates to have something to say.
- ❌ Two independent tasks in one agent (search + implement fused) — split them;
  search results return to the main conversation for judgment before implementation
  is dispatched.
