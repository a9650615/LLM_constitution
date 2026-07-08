# Install & wiring

Everything beyond the two-line install: updating, other harnesses, and the
no-plugin bare-checkout path. What the plugin contains: `README.md`.

## Claude Code (plugin)

```
/plugin marketplace add a9650615/LLM_constitution
/plugin install llm-constitution
```

The repo is self-hosting: `.claude-plugin/marketplace.json` lists the plugin with
`source: "./"`, so the same checkout serves as both the plugin and its own
marketplace listing.

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
- **Git checkout consumers** (bare checkout, below): plain `git pull` — no plugin
  machinery involved.

## Other harnesses: OpenCode / Codex / Hermes

The plugin machinery above is Claude Code-only, but the content installs cleanly
elsewhere. Two convergence points cover all three harnesses:

- **`AGENTS.md` is auto-read by all three** — inside this repo, zero wiring.
  Globally: OpenCode reads `~/.config/opencode/AGENTS.md`, Codex reads
  `~/.codex/AGENTS.md`; point either at (or copy from) this file.
- **`.agents/skills/` is the shared skill location** (the
  [agentskills.io](https://agentskills.io) open standard). This repo ships
  `.agents/skills/{dispatching,judgment,ten-laws}` as per-skill symlinks into
  `skills/`, so OpenCode and Codex discover the three cards automatically when
  working inside the repo (verified against OpenCode 1.15.7; Codex scans the
  same path per its docs, untested here). For global availability in any repo,
  copy or per-skill-symlink `skills/*` into `~/.agents/skills/` — all three
  harnesses scan it (Hermes: as an external skill directory).

Hermes specifics: skills also install one at a time from GitHub
(`hermes skills install a9650615/LLM_constitution/dispatching`, same for
`judgment`/`ten-laws` — its tap layout expects exactly this repo's `skills/`
shape). Hermes has no single-command install for a whole content bundle — its
"plugin" concept is Python tool/hook code, not a skill/doc package (confirmed
against obra/superpowers#1581, an open, unresolved cross-harness request for
the same gap).

Symlink caveats: per-skill symlinks work; symlinking the whole `skills`
directory is silently ignored (OpenCode 1.15.7, tested). On Windows checkouts
without symlink support, copy the three directories instead.

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
   OpenCode/Codex/Hermes: see "Other harnesses" above.
4. Smoke test: open a fresh session anywhere, ask "what are your environment
   rules" — it should recite the three core laws and, if pressed, name the Ten
   Base Laws as the supreme layer they sit under.

- [x] Deployed 2026-07-03 (founding session; re-deployed after the v2.0
  English-canonical restructure). Later additions (v2.1 plugin shape, v2.3 ten
  laws, v2.4 skill cards) change repo files only — the global router reads them
  in place; re-copy `agents/*.md` only if those files change.

If the box above is unchecked, the founding session was interrupted mid-deploy:
confirm with the user, then run the steps.
