# BINDINGS.md — Perishable specifics (expected to rot; fix freely with evidence)

Version 2.0, last verified 2026-07-03 on Claude Code 2.1.200.
The constitution (`CLAUDE.md`, `docs/`) is written against abstract tiers and should
survive years. This file binds those tiers to today's concrete names — it will NOT
survive years, by design. **When reality disagrees with this file, reality wins**:
verify, update this file, bump the date above, report to the user afterwards
(no prior approval needed — `docs/40-maintenance.md` §2).

## Model tiers → today's models (values for the Agent tool `model` param)

| Tier | Today | Use for |
|---|---|---|
| **cheap** | `haiku` | simple keyword/locate searches; batch-applying an already-solved pattern |
| **standard** | `sonnet` | default workhorse: semantic search, implementation, refactor, research, review |
| **strong** | `opus` | escalation target; second opinions; architecture calls |
| **special** | `fable` | user-enabled premium budget; never select it unless the user says so in this session |

If these names have rotted: cheap ≈ the fastest/cheapest current model;
standard ≈ the default coding model; strong ≈ the best generally-available model.
Re-verify via the `claude-code-guide` agent or official docs, then update this table.

## Reasoning effort

Settable **only** in agent definition frontmatter (`effort: low|medium|high|xhigh|max`),
not per Agent call. Need a different effort → create another custom agent definition.
The main session's effort is the user's business (`/effort`), not yours.

## Subagent types (Agent tool `subagent_type`)

Built-in: `Explore` (read-only search), `general-purpose` (all tools), `Plan`
(read-only planning), `claude-code-guide` (questions about Claude Code itself; runs cheap).
Custom, deployed in `~/.claude/agents/`: `scout` (cheap locate searches),
`verifier` (fresh-context acceptance; read-only).
If the harness rejects `scout`/`verifier`, they aren't deployed: fall back to
`Explore` / `general-purpose` + read-only instructions, tell the user, and see
`README.md` §Deployment.

## Budget (as of 2026-07)

User is on a tight (~Pro-level) plan and said "可以問我 / you can ask me" (2026-07-03).
Ask-first spend thresholds live in `docs/10-dispatch.md` §7 (authoritative):
≥3 parallel agents, or multi-round strong tier.

## Non-Claude agent wiring (as of 2026-07)

Machine-global rules for non-Claude agents: `~/claude-ops/AGENTS.md`.
- **aider**: loaded via `read:` in `~/.aider.conf.yml`; talks to local proxy
  `http://127.0.0.1:4000`, model `openai/coder-strong`.
- **OpenCode**: installed (`~/.local/bin/opencode`); global rules
  `~/.config/opencode/AGENTS.md` is a symlink to `~/claude-ops/AGENTS.md`.
  Repo-level `AGENTS.md` still wins inside a repo.
- **goose**: installed (`~/.config/goose/profiles.yaml`); no global-rules wiring
  (2026-07-03) — wire on first use.
- **mem0 plugin** (Claude Code): user installed it 2026-07-04; a SessionStart hook
  injects memory instructions (`~/.mem0/settings.json`). Coexists with the native
  file-based memory — treat mem0 as supplementary until the user says otherwise.

## Local model roster (LiteLLM proxy at 127.0.0.1:4000, per opencode config 2026-07-03)

Local: `router-1b` (qwen2.5 1.5b), `resident-small` (gemma4 e4b), `main-70b`
(qwen2.5 72b), `coder-fast` (qwen2.5-coder 7b), `coder-strong` (qwen2.5-coder 32b,
aider default), `coder-thinking` (deepseek-r1 14b), `coder-agentic` (gemma4 26b,
opencode default), `vlm-qwen2vl` (vision).
Cloud routes via same proxy: `main-cloud`/`coder-cloud` (claude-sonnet-4-6),
`thinking-cloud` (claude-opus-4-8), `gpt4o-cloud`, `gemini-cloud` (gemini-2.5-pro).
Authoritative list: `curl -s http://127.0.0.1:4000/v1/models` or
`~/.config/opencode/config.json`. Local ≤32B models are execution-grade only —
hold them to `AGENTS.md`'s seven rules, don't hand them judgment calls.

## Quick re-verification commands

- Proxy alive: `curl -s -m 3 http://127.0.0.1:4000/v1/models`
- Custom agents deployed: `ls ~/.claude/agents/`
- OS still Bazzite/immutable: `head -4 /etc/os-release; command -v rpm-ostree`
- Claude Code surface (models/params) changed: ask the `claude-code-guide` agent
