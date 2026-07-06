# claude-ops — the AI operating institution for this machine

Founded 2026-07-03 by a one-off Fable 5 session. Purpose: externalize a strong
model's judgment into files, so that every future session — any model tier, Claude
or not — runs stronger. Rationale: `docs/00-diagnosis.md` (中文).

**Design for durability**: timeless principles live in the constitution
(`CLAUDE.md`, `docs/`); perishable facts (model names, budgets, tool mechanics)
live in `BINDINGS.md` and are expected to rot and be re-verified. English files are
canonical (cheaper tokens); `zh/` holds Chinese mirrors for the user.

## File map

| File | Content |
|---|---|
| `CLAUDE.md` | master constitution: environment facts + routing table + three core laws, subordinate to the Ten Base Laws (auto-loaded every Claude session) |
| `docs/05-ten-laws.md` | the Ten Base Laws — the supreme layer above the three core laws; every other file is subordinate to it |
| `BINDINGS.md` | perishable bindings: tier→model names, effort mechanics, budget, local model roster, agent wiring |
| `AGENTS.md` | the eight-rule constitution for non-Claude agents (aider/OpenCode/goose and local models — Qwen/Gemma/DeepSeek, see BINDINGS.md) |
| `docs/10-dispatch.md` | dispatch rules: delegate-vs-DIY, tiers, escalation ladder, verify-never-self-verify, spend discipline |
| `docs/15-token-economy.md` | context hygiene for the main conversation: reading/output/tool-call discipline, long-context checkpointing, what never to economize |
| `docs/20-judgment.md` | judgment rubrics R1–R6 with positive/counter examples |
| `docs/30-templates.md` | delegation prompt templates ×5 (search/implement/refactor/research/review) |
| `docs/40-maintenance.md` | maintenance protocol: git snapshots, permission levels, lesson format, compaction, language policy, version stamps |
| `docs/00-diagnosis.md` | 中文, archival — the three harness ailments this institution treats |
| `docs/90-letter.md` | 中文, archival — letter from the founding session: context + degradation modes |
| `LESSONS.md` | machine-specific pitfall log (appendable; see docs/40 §3) |
| `zh/` | Chinese mirrors of CLAUDE.md and docs/05, docs/10–40 (for the user; headers name the mirrored version) |
| `agents/` | custom subagent definitions (scout, verifier) — source of truth, deployed to `~/.claude/agents/` |
| `backups/` | pre-edit copies for out-of-repo files and git-less contexts (docs/40 §1) |
| `.claude-plugin/plugin.json` | plugin manifest — this repo doubles as a Claude Code plugin (`llm-constitution`) |
| `.claude-plugin/marketplace.json` | self-hosted marketplace listing (`source: "./"`) — lets `/plugin marketplace add` + `/plugin install` pull this same repo |
| `commands/` | slash commands: `/verify` (fresh-context acceptance), `/lesson` (record pitfall), `/rebind` (re-verify BINDINGS.md), `/handoff` (session handoff file) |
| `skills/` | model-invoked skills: `dispatching` (delegation discipline), `judgment` (rubrics R1–R6), `ten-laws` (constitutional questions, the supreme layer) |

This directory is a **git repo** — history is the primary audit trail.
Remote: `https://github.com/a9650615/LLM_constitution.git` (push after every
verified commit; the remote is the disaster-recovery copy).

## Deployment (what makes every session pick this up)

1. Global router `~/.claude/CLAUDE.md` → points here (sessions in any directory).
2. `agents/*.md` copied to `~/.claude/agents/` (scout/verifier available everywhere).
3. Non-Claude: `~/.aider.conf.yml` has a `read:` pointer to this repo's `AGENTS.md`
   (literal path recorded in `BINDINGS.md` §Non-Claude agent wiring);
   `~/.config/opencode/AGENTS.md` is a symlink to `AGENTS.md` here. goose: not wired.
4. Smoke test: open a fresh session anywhere, ask "what are your environment rules" —
   it should recite the three core laws (and, if pressed, name the Ten Base Laws as
   the supreme layer they sit under).

- [x] Deployed 2026-07-03 (founding session; re-deployed after the v2.0
  English-canonical restructure). Later additions (v2.1 plugin shape, v2.3 ten
  laws, v2.4 skill cards) change repo files only — the global router reads them
  in place; re-copy `agents/*.md` only if those files change.

If the box above is unchecked, the founding session was interrupted mid-deploy:
confirm with the user, then run the steps.

## Plugin shape (as of 2026-07-06)

This repo doubles as a Claude Code plugin (`llm-constitution`): manifest in
`.claude-plugin/`, plus `commands/`, `skills/`, `agents/`.

**Progressive disclosure** (token economy by design): only skill descriptions sit
in a session's context by default. Invoking a skill loads a ~40-line *card* — the
operative core of its doc — not the doc itself; the card names the one section to
read when a situation exceeds it. Dispatch templates embed the relevant rules
inline in the subagent prompt, so subagents never load the constitution at all;
non-Claude/small models get only the ≤80-line `AGENTS.md` floor. Precedence when
summaries drift: full doc wins over card, Ten Base Laws win over everything.

**Installation / marketplace wiring** (added 2026-07-06, superseding the
2026-07-04 "not set up yet" decision): `.claude-plugin/marketplace.json` makes
this repo self-hosting — `source: "./"` points at the repo root, so the same
checkout serves as both the plugin and its own marketplace listing. Install
with:

```
/plugin marketplace add a9650615/LLM_constitution
/plugin install llm-constitution
```

This machine still primarily consumes the institution via the global router +
deployed agents (see Deployment above), not via plugin install — the two paths
coexist. Commands and skills locate the docs by checking `~/claude-ops/` first
and falling back to the plugin root, so they work in either mode.

**Updating an installed plugin** (facts verified 2026-07-06 against
code.claude.com/docs/en/discover-plugins and /en/plugins):

- Release side (this repo): update delivery is driven by `plugin.json`'s
  `version` field — installed users only receive an update when it is bumped
  (bump rules: `docs/40-maintenance.md` §7). Push alone is not a release.
- Consumer side, manual: `/plugin marketplace update llm-constitution-marketplace`
  refreshes the catalog and picks up the new version, then `/reload-plugins`
  when prompted.
- Consumer side, automatic: third-party marketplaces have auto-update OFF by
  default. Enable per-marketplace: `/plugin` → Marketplaces → select it →
  Enable auto-update; Claude Code then refreshes and updates at startup.
- Git checkout consumers (this machine's global-router mode): plain `git pull`
  — no plugin machinery involved.
