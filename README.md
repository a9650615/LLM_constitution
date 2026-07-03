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
| `CLAUDE.md` | master constitution: environment facts + routing table + three core laws (auto-loaded every Claude session) |
| `BINDINGS.md` | perishable bindings: tier→model names, effort mechanics, budget, local model roster, agent wiring |
| `AGENTS.md` | the seven-rule constitution for non-Claude agents (aider/OpenCode/goose/local GLM/Qwen/Gemma) |
| `docs/10-dispatch.md` | dispatch rules: delegate-vs-DIY, tiers, escalation ladder, verify-never-self-verify, spend discipline |
| `docs/20-judgment.md` | judgment rubrics R1–R6 with positive/counter examples |
| `docs/30-templates.md` | delegation prompt templates ×5 (search/implement/refactor/research/review) |
| `docs/40-maintenance.md` | maintenance protocol: git snapshots, permission levels, lesson format, compaction, language policy, version stamps |
| `docs/00-diagnosis.md` | 中文, archival — the three harness ailments this institution treats |
| `docs/90-letter.md` | 中文, archival — letter from the founding session: context + degradation modes |
| `LESSONS.md` | machine-specific pitfall log (appendable; see docs/40 §3) |
| `zh/` | Chinese mirrors of CLAUDE.md and docs/10–40 (for the user; headers name the mirrored version) |
| `agents/` | custom subagent definitions (scout, verifier) — source of truth, deployed to `~/.claude/agents/` |
| `backups/` | pre-edit copies when git is unavailable (docs/40 §1) |

This directory is a **git repo** — history is the primary audit trail.

## Deployment (what makes every session pick this up)

1. Global router `~/.claude/CLAUDE.md` → points here (sessions in any directory).
2. `agents/*.md` copied to `~/.claude/agents/` (scout/verifier available everywhere).
3. Non-Claude: `~/.aider.conf.yml` has `read: ["/var/home/birdyo/claude-ops/AGENTS.md"]`;
   `~/.config/opencode/AGENTS.md` is a symlink to `AGENTS.md` here. goose: not wired.
4. Smoke test: open a fresh session anywhere, ask "what are your environment rules" —
   it should recite the three core laws.

- [x] Deployed 2026-07-03 (founding session; re-deployed after the v2.0
  English-canonical restructure)

If the box above is unchecked, the founding session was interrupted mid-deploy:
confirm with the user, then run the steps.
