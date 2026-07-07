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

The repo is self-hosting: `.claude-plugin/marketplace.json` lists the plugin with
`source: "./"`, so the same checkout serves as both the plugin and its own
marketplace listing.

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
   `BINDINGS.md`, which names the one machine it binds.
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
| `BINDINGS.md` | perishable bindings: tier→model names, effort mechanics, budget, local model roster, agent wiring |
| `AGENTS.md` | the eight-rule floor constitution for non-Claude agents (aider/OpenCode/goose and local models — Qwen/Gemma/DeepSeek, see BINDINGS.md) |
| `docs/10-dispatch.md` | dispatch rules: delegate-vs-DIY, tiers, escalation ladder, verify-never-self-verify, spend discipline |
| `docs/15-token-economy.md` | context hygiene for the main conversation: reading/output/tool-call discipline, long-context checkpointing, what never to economize |
| `docs/20-judgment.md` | judgment rubrics R1–R6 with positive/counter examples |
| `docs/30-templates.md` | delegation prompt templates ×5 (search/implement/refactor/research/review) |
| `docs/40-maintenance.md` | maintenance protocol: git snapshots, permission levels, lesson format, compaction, language policy, version stamps |
| `docs/00-diagnosis.md` | 中文, archival — the three harness ailments this institution treats |
| `docs/90-letter.md` | 中文, archival — letter from the founding session: context + degradation modes |
| `LESSONS.md` | machine-specific pitfall log (appendable; see docs/40 §3) |
| `backups/` | pre-edit copies for out-of-repo files and git-less contexts (docs/40 §1) |
| `zh/` | Chinese mirrors of CLAUDE.md and docs/05, docs/10–40 (headers name the mirrored version) |
| `agents/`, `commands/`, `skills/` | the plugin surface (see "What you get") |
| `.claude-plugin/` | plugin manifest + self-hosted marketplace listing |
| `LICENSE` | MIT |

English files are canonical (cheaper tokens); `zh/` holds Chinese mirrors for the
user. The repo's git history is the primary audit trail; the remote
(`https://github.com/a9650615/LLM_constitution.git`) is the disaster-recovery copy —
push after every verified commit.

## Updating an installed plugin

Facts verified 2026-07-06 against code.claude.com/docs/en/discover-plugins and
/en/plugins:

- **Release side (this repo)**: update delivery is driven by `plugin.json`'s
  `version` field — installed users only receive an update when it is bumped
  (bump rules: `docs/40-maintenance.md` §7). Push alone is not a release.
- **Consumer side, manual**: `/plugin marketplace update llm-constitution-marketplace`
  refreshes the catalog and picks up the new version, then `/reload-plugins`
  when prompted.
- **Consumer side, automatic**: third-party marketplaces have auto-update OFF by
  default. Enable per-marketplace: `/plugin` → Marketplaces → select it →
  Enable auto-update; Claude Code then refreshes and updates at startup.
- **Git checkout consumers** (router mode, below): plain `git pull` — no plugin
  machinery involved.

## Alternative: bare checkout (no plugin machinery)

The founding machine consumes this institution directly; the two paths coexist.
Commands and skills locate the docs by checking `~/claude-ops/` first and falling
back to the plugin root, so they work in either mode.

1. Global router `~/.claude/CLAUDE.md` → points at the checkout (sessions in any
   directory pick it up).
2. `agents/*.md` copied to `~/.claude/agents/` (scout/verifier available
   everywhere); re-copy only when those files change.
3. Non-Claude agents: `~/.aider.conf.yml` has a `read:` pointer to `AGENTS.md`
   (literal path recorded in `BINDINGS.md` §Non-Claude agent wiring);
   `~/.config/opencode/AGENTS.md` is a symlink to `AGENTS.md`. goose: not wired.
4. Smoke test: open a fresh session anywhere, ask "what are your environment
   rules" — it should recite the three core laws and, if pressed, name the Ten
   Base Laws as the supreme layer they sit under.

- [x] Deployed 2026-07-03 (founding session; re-deployed after the v2.0
  English-canonical restructure). Later additions (v2.1 plugin shape, v2.3 ten
  laws, v2.4 skill cards) change repo files only — the global router reads them
  in place; re-copy `agents/*.md` only if those files change.

If the box above is unchecked, the founding session was interrupted mid-deploy:
confirm with the user, then run the steps.

## Provenance

Founded 2026-07-03 by a one-off Fable 5 session. Purpose: externalize a strong
model's judgment into files, so that every future session — any model tier, Claude
or not — runs stronger. Rationale: `docs/00-diagnosis.md` (中文).

## License

MIT — see `LICENSE`.
