# 15 — Token economy (context hygiene for the main conversation)

Version 1.0 (2026-07-04). Canonical (English); 中文鏡像 `zh/15-token-economy.md`.
`docs/10-dispatch.md` already covers the dispatch side (delegate grunt work, report
contracts, tier order). This file covers what the **main conversation itself** must
do. Budget context: `BINDINGS.md` §Budget.

## 1. Reading discipline

- **Read the section, not the file.** Locate first (Grep/Glob or a known line
  range), then Read with offset/limit. Reading a 2000-line file to use 30 lines
  wastes ~98% of the spend.
- **Never re-read what is already in context.** A successful Write/Edit already
  confirms the file state — reading it back yourself is waste AND self-verification
  (core law 2 says acceptance read-backs are a *fresh agent's* job, not yours).
- **Session start: trust the constitution's environment facts.** Re-exploring the
  machine (OS checks, tool discovery) costs 10–30 tool calls per session and is the
  single biggest historical leak (`docs/00-diagnosis.md`, ailment 1).
- Expecting to read ≥3 files in full? That is dispatch territory —
  `docs/10-dispatch.md` §1.

## 2. Output discipline

- **Answer first.** No background windup; the first sentence carries the verdict.
- **No raw dumps into the conversation** — logs, diffs, scan results, file listings
  >30 lines go to a file; the conversation gets the path + a 3-line summary. (Same
  contract subagents live under, `docs/10` §4 — it applies to you too.)
- **Don't echo file content back** to the user after editing; state what changed
  and where (`path:line`).
- Reply length tracks question weight: a one-line question gets a one-paragraph
  answer, not a report with headers.

## 3. Tool-call discipline

- **Batch independent calls** in one block (parallel); sequential calls are for
  actual dependencies only.
- Don't run a command to confirm what a tool result already told you.
- Prefer dedicated tools (Read/Grep/Glob) over shell `cat`/`grep` — cheaper,
  structured, no permission churn.
- Load routed docs and skills **on demand only**, and never reload one already in
  context this session.

## 4. When context grows long

- Long work → **checkpoint to files as you go** (the institution itself was built
  this way: every finished piece lands on disk before the next starts). If the
  session dies, files are what survives.
- Feeling the context bloat → write a handoff early (`commands/handoff.md` shape:
  goal / done+evidence / in-flight / failure trails / next step) rather than
  hoping to finish before the window closes.
- Finish the current scope before accepting new scope into the same session.

## 5. What NOT to economize

- **Verification** (`docs/10` §6) — the quality floor is never traded for tokens.
- **Reading the user's actual request** — re-reading their words, clause by
  clause, is the cheapest bug-prevention that exists (`docs/20` R2).
- **The failure trail in an escalation prompt** (`docs/10` §5) — cutting it
  guarantees paying for the same failure twice.
