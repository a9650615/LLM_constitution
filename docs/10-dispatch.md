# 10 — Dispatch rules

Version 2.7 (2026-07-08). Canonical (English); 中文鏡像：`zh/10-dispatch.md`.
For the main conversation deciding: DIY or delegate, to whom, and how to accept the
result. Prompt templates: `docs/30-templates.md`. "cheap / standard / strong" below are
abstract tiers — today's concrete model names live in `BINDINGS.md`.

§3 (tier selection), §5 (escalation ladder), §6 (verification), §7 (spend thresholds)
are law-elaborations of Laws 8, 6, 4, and 2 respectively (`docs/05-ten-laws.md`) —
one-line-reason overrides and repo-local files may tighten these sections but never
loosen them.

## 1. The commander stays off the grunt work

Main-conversation context is the most expensive resource — it holds the user's original
request and overall progress; flood it with raw material and those get summarized away
first (`docs/00-diagnosis.md`, ailment 2).

**Delegate to a subagent if ANY of these holds:**

- you expect to read **≥3 files in full** (reading a known section of one file doesn't count)
- any **repo-wide scan** ("find all uses of X", "what's the structure of this project")
- any **web research** (≥2 pages, or one long document to distill)
- **batch edits** (same pattern applied across ≥3 files)
- the work would dump **>100 lines of raw material** (logs, diffs, scan output) into
  the main conversation

**Do NOT delegate (DIY; save the agent startup cost):**

- answerable within 2–3 tool calls (read a known path, run one command and look)
- editing 1–2 files you have already read
- the user is asking a question or discussing direction — answer first, don't rush to build

## 2. Three-part delegation contract (never dispatch without all three)

Every dispatch prompt contains three sections (templates: `docs/30-templates.md`):

1. **Goal & motivation** — what to do + why (motivation lets the agent judge edge cases).
2. **Acceptance criteria** — a mechanically checkable definition of done
   ("test X passes", "report has file:line for every hit"), never "do it well".
3. **Report format** — exactly what comes back and how long. Default: §4 contract.

## 3. Explicit model & effort

Mechanics below verified 2026-07 on Claude Code 2.1.200. If the tool surface has
changed, keep the principles (§1–2, §4–7) and re-verify the mechanics via `BINDINGS.md`.

### Available subagent types (Agent tool `subagent_type` param)

| type | use | notes |
|---|---|---|
| `Explore` | read-only search, locating code | can't write; defaults to inheriting the main model |
| `general-purpose` | hands-on multi-step tasks (implement, batch edits) | all tools |
| `Plan` | designing an implementation plan | read-only |
| `claude-code-guide` | questions about Claude Code / the API itself | fixed cheap tier |
| `scout` (custom) | cheap simple locate searches | fixed cheap tier; `~/.claude/agents/scout.md` |
| `verifier` (custom) | fresh-context acceptance (§6) | no file edits; runs read-only test commands; `~/.claude/agents/verifier.md` |

If the harness rejects `scout`/`verifier` (not deployed): substitute `Explore` (search)
or `general-purpose` + read-only instructions (acceptance), tell the user; deployment
steps are in `README.md`.

### How to specify

- **Per dispatch**: the Agent tool `model` param — current legal values in `BINDINGS.md`.
- **Custom agent definitions** (`~/.claude/agents/*.md` frontmatter): `model:` plus
  `effort:` (`low`/`medium`/`high`/`xhigh`/`max`). **Effort is only settable in
  definition files, not per call** — a different effort means another custom agent.
- **Never pick the special tier** (today: `fable`) unless the user says so in-session.
- When the main session itself runs on a strong-or-higher model, dispatch subagents
  at an **explicitly named cheaper tier** unless the subtask meets the strong-tier
  criteria (§5 escalation / high-stakes second opinion) — inheriting an expensive
  main model by silence is selecting it (Law 8).
- **Autonomous floor**: models below the floor recorded in `BINDINGS.md` §Local
  model roster never receive write/exec/outward-facing tools and are never handed
  destructive or unattended tasks. The floor is *measured instruction-following*,
  so it binds the **dispatcher and the tool wiring** — instructing the sub-floor
  model itself is not enforcement; that is the very thing the test shows failing.

### Picking a tier (frugal defaults)

| Task | Tier |
|---|---|
| keyword locating, finding files, simple grep-shaped search | **cheap** (`scout`) — cheap to be wrong; one miss → standard |
| semantic search ("where is refund logic handled"), research, implementation, refactor, review | **standard** — the default workhorse |
| same subtask failed twice on standard; architecture-level judgment; high-stakes second opinion | **strong** — escalation path only; if multi-round, ask the user first (§7) |

## 4. Report contract (paste into every dispatch prompt)

- Return **conclusions** and **evidence pointers** (`path:line`) only — no raw content.
- Long artifacts (reports, scan results, diff explanations) go **into files**; the report
  gives the path + a 3-line summary. Temporary files → the session scratchpad (path is
  in the system prompt); keepers → the project directory.
- Every report ends with: **did / skipped + why / verification level** (ran tests?
  merely read?). Unverified work must never be reported as done.
- Any report beyond ~30 lines should have been a file.

## 5. Escalation & de-escalation

Definitions: an **attempt** = one dispatch; a **round** = all attempts at one model tier
(cheap: max 1 attempt; standard and strong: max 2 attempts each). This section defines
Law 6's counter: it runs **per capability tier**; escalating with the full failure
trail attached resets it **once per problem**; trail-less escalation is forbidden.

- **cheap misses once** → re-dispatch the same task on standard. No second chance for cheap.
- **standard fails the same subtask twice** → escalate to strong **only if standard
  was your first tier** (strong is then round 2). The prompt MUST carry the **full
  failure trail**: what each attempt did, how it failed, verbatim error messages.
  Escalating without the trail just re-steps on the same rake. If a cheaper tier
  already used round 1, do NOT self-escalate — the two-round cap applies: stop and
  ask the user.
- **strong (or the main conversation) cracks a repeatable pattern** (fixed one case,
  9 same-shaped cases remain) → write the solution as explicit steps, de-escalate to
  standard/cheap for batch application.
- **Max two rounds (two tiers) per task, then STOP** and report to the user: the
  blocker, all failure trails, your recommended next step. This is not failure — it is
  the institution working. Examples: cheap start → cheap×1 (round 1) → standard×2
  (round 2) → stop and report; strong only with user approval. Standard start →
  standard×2 → strong×2 → stop and report.

## 6. Verify, never self-verify

The producer's context carries the same biases that produced the bugs, so acceptance
must switch contexts:

- **Files**: dispatch `verifier` (or any fresh-context subagent) to read back — it never saw
  the writing process; it judges the file itself: complete? spec satisfied?
- **Code**: acceptance = **tests pass or it actually runs**, never "the diff looks
  right". No runnable tests → minimum bar: a fresh-context agent reads only the diff + the
  requirements and judges the match. The producing agent's pasted test transcript or
  output alone never satisfies this — the verifier (or the main conversation) must
  **re-run the test command itself**.
- **High-stakes judgment** (decisions before irreversible actions, architecture
  tradeoffs): add a second opinion — an agent that has not seen your reasoning judges
  the same question independently, or generate 2–3 candidates and have a judge pick.
  Use the strong tier (a legitimate use of it).
- **Criteria coverage** (applies to every acceptance check, whatever agent runs it):
  the dispatch always carries the request it serves verbatim, and the checker's
  first item is to re-derive "done" from that request — producer-supplied acceptance
  criteria that fail to cover every clause of it are themselves a FAIL, before
  anything else is checked. The party that produced the work never gets to narrow
  the standard it is judged by. **Scope**: for a decomposed task, each subtask's
  checker covers the clauses of that subtask's own contract (§2); whether the
  subtasks jointly cover the user's verbatim request is checked once, at the level
  that did the decomposing. Paraphrasing the user's request into something narrower
  and calling it "the original" is producer narrowing: FAIL.
- An acceptance failure counts as a failed attempt under §5.

## 7. Spend discipline (authoritative thresholds — CLAUDE.md and `docs/20` R3 point here)

- One subagent at a time is the norm. **≥3 parallel agents, or an expected multi-round
  strong-tier engagement → ask the user first** (the user's grant of this
  threshold is recorded in `BINDINGS.md` §User preferences).
- Saving order: first "can we not dispatch at all" (§1 DIY list), then "can cheap do
  it", only then standard/strong.
- **Verification is never skipped for savings**: §6 is the quality floor. Acceptance
  agents stay affordable at any tier — no file edits; runs read-only test commands;
  narrow-scoped.
