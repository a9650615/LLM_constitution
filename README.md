# llm-constitution

**An operating constitution for AI coding agents**, packaged as a Claude Code plugin.

At the top: the **Ten Base Laws** — invariant-grounded, precedence-ordered,
model-agnostic. Below them: dispatch discipline (the commander stays off the grunt
work), never-self-verify acceptance, escalation ladders, judgment rubrics, and a
perishable bindings layer that absorbs model-name rot. Written to keep binding any
LLM — any vendor, any capability tier — for years.

## Why a constitution

- **Durable by construction.** Every law rests on an invariant about agents acting
  in the world ("a claim is not evidence", "some actions cannot be undone") — facts
  that do not change as models improve. Perishable specifics (today's model names,
  budgets, tool mechanics) are quarantined in `BINDINGS.md`, expected to rot, and
  paired with re-verification triggers.
- **Quality floors that never flex.** Work is accepted only by a context that did
  not produce it; "done" is a checkable state, not a feeling; two failures of one
  approach end that approach. Verification is never skipped for savings.
- **Token economy by design.** Progressive disclosure: only skill descriptions sit
  in a session's context by default. Invoking a skill loads a ~40-line *card* — the
  operative core of its doc — not the doc itself; the card names the one section to
  read when a situation exceeds it. Subagent prompts embed the relevant rules
  inline, so subagents never load the constitution at all. Small or non-Claude
  models get only the ≤80-line `AGENTS.md` floor. Precedence when summaries
  drift: full doc wins over card, Ten Base Laws win over everything.

## Install

```
/plugin marketplace add a9650615/LLM_constitution
/plugin install llm-constitution
```

Updating, other harnesses (OpenCode / Codex / Hermes), and the no-plugin
bare-checkout path: `INSTALL.md`.

## What you get

| Kind | Name | Purpose |
|---|---|---|
| Skill | `ten-laws` | constitutional questions — what is absolute, precedence, how laws are edited |
| Skill | `dispatching` | delegation discipline: delegate-vs-DIY, tier selection, escalation ladder |
| Skill | `judgment` | rubrics R1–R6: when it's done, when to ask, when to change approach |
| Command | `/verify` | fresh-context acceptance check before claiming a task done |
| Command | `/lesson` | record a machine/environment pitfall into `LESSONS.md` (format-checked, deduplicated) |
| Command | `/rebind` | re-verify the perishable facts in `BINDINGS.md` |
| Command | `/handoff` | write a session handoff file before context runs out |
| Agent | `scout` | cheap read-only locate searches (fixed cheap tier) |
| Agent | `verifier` | fresh-context acceptance checker — no file edits, read-only test commands |

## How it's structured

Precedence, top to bottom — a lower layer never overrides a higher one:

1. **`docs/05-ten-laws.md`** — the Ten Base Laws, the supreme layer. Editable only
   through an explicit protocol (proposal → user approval → fresh-context read-back).
2. **`CLAUDE.md`** — operational entry point: routing table and three of the laws
   restated for fast loading. Universal by design — machine facts live in
   `BINDINGS.md`, a per-machine file generated from `BINDINGS.template.md` via
   `/rebind` (not shipped; may not exist yet on a fresh checkout) that names the
   one machine it binds.
3. **`docs/10–40`** — operational statutes: dispatch, token economy, judgment,
   templates, maintenance. Defaults, overridable with a stated one-line reason —
   except the sections marked as law-elaborations, which may only be tightened.
4. **`BINDINGS.md` / `LESSONS.md`** — perishable facts and pitfall log; models may
   update these themselves (tighten-only, evidence required).

Models may tighten the institution on their own; only the human may loosen it.

## File map

| File | Content |
|---|---|
| `docs/05-ten-laws.md` | the Ten Base Laws — the supreme layer; everything else is subordinate |
| `CLAUDE.md` | master operational constitution (auto-loaded every Claude session) |
| `BINDINGS.md` | per-machine, generated (gitignored, not shipped): tier→model names, effort mechanics, budget, local model roster, agent wiring. Run `/rebind` to create it |
| `BINDINGS.template.md` | shipped skeleton for `BINDINGS.md` — copy and fill every placeholder locally |
| `AGENTS.md` | the eight-rule floor constitution for non-Claude agents (aider/OpenCode/goose and local models — Qwen/Gemma/DeepSeek, see BINDINGS.md) |
| `docs/10-dispatch.md` | dispatch rules: delegate-vs-DIY, tiers, escalation ladder, verify-never-self-verify, spend discipline |
| `docs/15-token-economy.md` | context hygiene for the main conversation: reading/output/tool-call discipline, long-context checkpointing, what never to economize |
| `docs/20-judgment.md` | judgment rubrics R1–R6 with positive/counter examples |
| `docs/30-templates.md` | delegation prompt templates ×5 (search/implement/refactor/research/review) |
| `docs/40-maintenance.md` | maintenance protocol: git snapshots, permission levels, lesson format, compaction, language policy, version stamps |
| `INSTALL.md` | install details: plugin updates, OpenCode/Codex/Hermes wiring, bare checkout |
| `LESSONS.md` | machine-specific pitfall log (appendable; see docs/40 §3) |
| `archive/` | frozen founding-era records (中文, append-only): diagnosis + founding letter. Era-bound machine facts stay here — never in `docs/` |
| `backups/` | pre-edit copies for out-of-repo files and git-less contexts (docs/40 §1) |
| `zh/` | Chinese mirrors of CLAUDE.md and docs/05, docs/10–40 (headers name the mirrored version) |
| `agents/`, `commands/`, `skills/` | the plugin surface (see "What you get") |
| `.agents/skills/` | per-skill symlinks into `skills/` for OpenCode/Codex discovery (agentskills.io standard location) |
| `.claude-plugin/` | plugin manifest + self-hosted marketplace listing |

English files are canonical (cheaper tokens); `zh/` holds Chinese mirrors for the
user. The repo's git history is the primary audit trail; the remote
(`https://github.com/a9650615/LLM_constitution.git`) is the disaster-recovery copy —
push after every verified commit.

## Provenance

Founded 2026-07-03 by a one-off Fable 5 session. Purpose: externalize a strong
model's judgment into files, so that every future session — any model tier, Claude
or not — runs stronger. Rationale: `archive/00-diagnosis.md` (中文).

## License

MIT — see `LICENSE`.
