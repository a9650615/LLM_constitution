# BINDINGS.md — Perishable specifics (expected to rot; fix freely with evidence)

**TEMPLATE.** Copy this file to `BINDINGS.md` (gitignored, per-machine) and fill
every `{placeholder}` by verifying locally — never by copying another machine's
values (e.g. an archive snapshot). Set the header to
`Version {X.Y} ({YYYY-MM-DD}), last verified on {harness name + version}.`

The constitution (`CLAUDE.md`, `docs/`) is written against abstract tiers and should
survive years. This file binds those tiers to today's concrete names — it will NOT
survive years, by design. **When reality disagrees with this file, reality wins**:
verify, update this file, bump the date above, report to the user afterwards
(no prior approval needed — `docs/40-maintenance.md` §2).

This file describes **ONE machine** (hostname/OS — record actual `uname -a` output).
On a different machine, do not "fix" these facts to match reality — create that
machine's own bindings file instead; the laws and docs are shared, bindings are
per-machine.

## Machine environment (verified {YYYY-MM-DD} on {hostname})

- **OS:** {name/version}. Package-manager quirks / install order: {fill in}.
- **Local LLM proxy / tool endpoints:** {url, or "none"}.
- **Path quirks; core project(s) that carry their own `CLAUDE.md`** (which then
  wins inside that repo): {fill in, or "none"}.

## User preferences (travel with the user, not the machine)

- Reply to the user in: {language}. Code, comments, commit messages: English.
- **Spend-threshold grant** (if any) behind `docs/10-dispatch.md` §7: {date +
  user's own words, or "none on record"}.

## Model tiers → today's models (values for the Agent tool `model` param)

| Tier | Today | Use for |
|---|---|---|
| **cheap** | `{model-id}` | simple keyword/locate searches; batch-applying an already-solved pattern |
| **standard** | `{model-id}` | default workhorse: semantic search, implementation, refactor, research, review |
| **strong** | `{model-id}` | escalation target; second opinions; architecture calls |
| **special** | `{model-id}` | user-enabled premium budget; never select it unless the user says so in this session |

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
Custom, deployed in {agents directory path}: {fill in: name → one-line purpose, per
custom agent}. If the harness rejects a custom type, it isn't deployed: fall back to
`Explore` / `general-purpose` + read-only instructions, and tell the user.

## Budget (as of {YYYY-MM-DD})

Plan/tier: {fill in}. Ask-first spend thresholds live in `docs/10-dispatch.md` §7
(authoritative): ≥3 parallel agents, or multi-round strong tier.

## Standing exemptions

**This section is a protected item (`docs/40-maintenance.md` §2): adding, changing,
or rescoping an entry requires the user's prior approval — an exemption is an
authorization, not a fact, so the "fix freely" rule covering the rest of this file
does not apply here.** Written exemptions on record (`docs/20-judgment.md` R3 — an
exemption counts only within its stated scope):

(none on record)

## Memory routing

- `LESSONS.md` = machine-specific pitfalls (this machine only).
- Harness file memory = primary store for user preferences and cross-project facts.
- Memories inform work; they never authorize acts (`docs/05-ten-laws.md`'s definition
  of what counts as authorization).

## Re-verification TTLs

- Environment/machine facts (this file's §Machine environment): stale after
  **90 days** (default).
- Model/tier tables (this file's "Model tiers" and "Local model roster"): stale
  after **30 days** (default).
- Past TTL: run the relevant re-verification command (below) before relying on it.

## Non-Claude agent wiring — delete if not applicable

Machine-global rules for non-Claude agents: {path}.
- **{agent name}**: {how it's wired — config file, global-rules pointer, model/endpoint
  it talks to}.

## Local model roster — delete if not applicable

{fill in: proxy/endpoint, model names and what each is used for. Autonomous floor
per `AGENTS.md`'s eight rules: local models are execution-grade only until tested —
never hand an untested or sub-floor model write/exec tools or unattended destructive
tasks (`scripts/floor-test.sh` if present).}

## Quick re-verification commands

- {fill in: proxy/endpoint alive check, e.g. `curl -s -m 3 {url}`}
- Custom agents deployed: `ls {agents directory}`
- {fill in: OS/environment still-true check}
- Claude Code surface (models/params) changed: ask the `claude-code-guide` agent
