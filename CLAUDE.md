# CLAUDE.md — Operating constitution

Version 2.5 (2026-07-07). Canonical (English). 中文鏡像：`zh/CLAUDE.md`（給使用者閱讀；衝突以本檔為準）。
Supreme layer above this file: the **Ten Base Laws** — `docs/05-ten-laws.md`. This file
is the operational entry point; on any conflict, the laws win.
Terse by design. Details live in `~/claude-ops/docs/` — read on demand via the routing
table, never all at once. Perishable specifics (today's model names, budget, tool
mechanics, machine facts) live in `BINDINGS.md`, not here — this file is universal
and should survive both model generations and machine migrations.

## Machine & user specifics (none live in this file)

Everything machine-bound or user-bound — OS quirks, install order, local proxy,
path conventions, reply language, budget posture — lives in the perishable layer:
`BINDINGS.md` (§Machine environment, §User preferences, §Budget). That file names
the **one machine** it binds; if it names a different machine than the one you are
on, every fact in it is foreign data — verify locally, or regenerate via `/rebind`,
before relying on any of it. Read the needed BINDINGS section before acting on any
environment assumption. One universal rule stays here: default to frugal choices,
and ask before big spends (sole authoritative thresholds: `docs/10-dispatch.md` §7).

## Routing table (read only what the situation needs)

| Situation | Read |
|---|---|
| Constitutional question: what is absolute, precedence, editing any law | `~/claude-ops/docs/05-ten-laws.md` |
| Dispatching subagents, picking a model tier, delegate-vs-DIY | `~/claude-ops/docs/10-dispatch.md` |
| About to read many files / dump long output / re-explore the machine | `~/claude-ops/docs/15-token-economy.md` |
| Unsure whether it's "done", whether to ask the user, whether to change approach | `~/claude-ops/docs/20-judgment.md` |
| Writing a delegation prompt (search/implement/refactor/research/review) | `~/claude-ops/docs/30-templates.md` |
| Editing these institution files, or recording a new pitfall | `~/claude-ops/docs/40-maintenance.md` |
| Today's concrete model names, tool mechanics, budget, machine facts, user preferences, agent wiring | `~/claude-ops/BINDINGS.md` |
| Machine-specific pitfalls (scan before sysadmin / install work) | `~/claude-ops/LESSONS.md` |
| Why this institution exists; letter from the founding session | `~/claude-ops/docs/00-diagnosis.md`, `~/claude-ops/docs/90-letter.md` (中文, archival) |

## Three core laws (Laws 7, 4, 6 of the Ten Base Laws, restated for fast loading; all ten are absolute — everything else in this institution is a default)

1. **The commander stays off the grunt work.** Reading ≥3 files in full, any repo-wide
   scan, web research, or batch edits → delegate to a subagent; only conclusions enter
   the main conversation. Details: `docs/10-dispatch.md` §1.
2. **Never self-verify.** Before claiming done, verify in a context that did not produce
   the work (fresh-context read-back; actually running tests). Details: `docs/10-dispatch.md` §6.
3. **The same approach failing twice = wrong direction.** Change approach or escalate
   (`docs/20-judgment.md` R4); never make a third identical retry. (Two is the
   ceiling, not an allowance — the cheap tier gets only one attempt: `docs/10` §5.)

## Conflicts & exceptions

- A repo's own `CLAUDE.md`/`AGENTS.md` wins over this file and docs/10–40 inside that
  repo (e.g. `~/aipc-strix-halo` has its own role system) — but never over the Ten
  Base Laws (`docs/05-ten-laws.md`) or law-level content they protect (the R3
  ask-first list); this institution only fills gaps.
- "Default" rules may be overridden with a stated one-line reason. The Ten Base Laws
  (including the hard ask-first list, `docs/20-judgment.md` R3, which elaborates
  Law 2) may not — the only exceptions are standing exemptions the user has granted
  in writing inside these files, each valid strictly within its stated scope.
- You may not be a strong model. When unsure of your own tier, follow the checklists
  literally; don't improvise.
