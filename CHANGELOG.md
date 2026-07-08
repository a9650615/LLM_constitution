# Changelog

All notable changes to the `llm-constitution` plugin. Versions follow the rule in
`docs/40-maintenance.md` §7 (X.Y tracks CLAUDE.md; Z bumps for plugin-shipped
changes that don't touch it). Every `plugin.json` bump ships with an entry here
(lint-enforced). Backfilled 2026-07-07 from git history; commit hashes are the
authoritative detail.

## [2.7.1] — 2026-07-08
- Universal content promoted out of the Chinese archive (user-identified gap):
  the founding letter's degradation modes A–D existed only in `archive/90-letter.md`
  (中文) while docs/40's header cited them — the universal layer depended on an
  archival Chinese file for its own rationale. Now stated in English as docs/40
  v2.13 §9 (silent bypass / rule inflation / lesson landfill / stale facts, each
  with its counter-measure), with the archive kept as dated provenance. The three
  ailments needed no promotion — their substance was already inlined in docs/10
  §1/§5/§6 and docs/15 §1. zh/40 mirror synced (translated by a dispatched
  standard-tier agent).

## [2.7.0] — 2026-07-08
- Layout simplification (user-identified: the two archival files broke the
  universal docs/ format and carried era-bound machine facts). `docs/00-diagnosis.md`
  and `docs/90-letter.md` moved wholesale to new `archive/` — docs/ now holds only
  uniform universal statutes; the archive keeps founding-era facts as dated
  history, never as current truth (relocation note appended to each; content
  otherwise untouched, per the append-only rule). README slimmed: plugin-update
  mechanics, OpenCode/Codex/Hermes wiring, and the bare-checkout guide moved
  verbatim into new `INSTALL.md`. Cross-references updated (CLAUDE.md v2.7,
  docs/10 v2.9, docs/15 v1.4, docs/40 v2.12; zh mirrors synced); lint.sh drops
  the now-orphaned docs/00|90 cap exemption. Same-category stray caught by the
  verifier: floor-test.sh's usage example hardcoded the founding machine's proxy
  and model id — genericized to the ollama default + a BINDINGS pointer.

## [2.6.1] — 2026-07-08
- "Fresh context" gets an explicit definition (docs/10 v2.8 §6, mirrored in the
  dispatching and judgment cards): a different agent OR an objective tool run
  (compiler/lint/tests executed); the producer re-reading its own work in any
  form never qualifies; the check scales down in cost, never to self-inspection.
  Shipped per docs/40 §8: concrete failure was a live Haiku comprehension test
  (it read "fresh context" as "re-open the file in a fresh view" — self-verify
  in disguise); the fixed text was dry-run against Haiku, which then ruled
  correctly, including the no-automated-checks → dispatch-verifier edge case.

## [2.6.0] — 2026-07-08
- Universality sweep round 2 (user-identified stray): three user/machine-bound
  facts still lived in universal files. `~/aipc-strix-halo` example dropped from
  CLAUDE.md v2.6 §Conflicts (fact moved to BINDINGS §Machine environment);
  AGENTS.md v2.8 title drops "on this machine" and the header no longer names
  the LiteLLM proxy; docs/10 v2.7 §7 replaces the user quote + Mem0 key with a
  pointer to BINDINGS §User preferences (grant recorded there). zh mirrors
  synced; BINDINGS v2.6.

## [2.5.1] — 2026-07-08
- Cross-harness compatibility: new `.agents/skills/` directory with per-skill
  symlinks into `skills/` — OpenCode and Codex discover the three cards
  automatically inside the repo (agentskills.io standard location; verified
  empirically against OpenCode 1.15.7 via `opencode debug skill`; whole-dir
  symlinks are silently ignored, per-skill ones work). README gains an
  "Other harnesses: OpenCode / Codex / Hermes" section covering AGENTS.md
  auto-read on all three, global `~/.agents/skills/` install, and Hermes
  per-skill tap install. Hermes has no single-command whole-bundle install
  (its "plugin" concept is Python tool/hook code, confirmed against the
  still-open obra/superpowers#1581); no shim built — content paths cover it
  with zero new code and no code-exec trust flag.

## [2.5.0] — 2026-07-07
- Universality fix (user-identified category error): CLAUDE.md v2.5 and
  AGENTS.md v2.7 no longer carry ANY machine facts — the Bazzite/proxy/install
  facts moved into `BINDINGS.md` §Machine environment and §User preferences
  (the per-machine perishable layer, which names the one machine it binds).
  Universal files are now valid on any machine; a cloned repo can no longer
  feed one machine's facts to sessions on another. Cross-references updated
  (docs/15 v1.3, README, BINDINGS TTLs, docs/00 archival note).

## [2.4.11] — 2026-07-07
- Fable-tier adversarial re-review: standing exemptions become a protected
  ask-first item (closes an authorization-laundering path through the freely
  editable BINDINGS); criteria-coverage rule gains subtask scoping (closes a
  decomposition deadlock); skill-card edits restricted to restating their doc;
  §8 dry-runs must be recorded for the read-back verifier; §5 requires
  confirming CI green after push; lint guards against dead globs.
- Autonomous floor recorded in BINDINGS (measured: gemma3:4b passes the 4
  adversarial scenarios, qwen2.5:1.5b fails dangerously) with
  `scripts/floor-test.sh` as the re-verification method; enforcement placed on
  the dispatcher and tool wiring (docs/10 §3, AGENTS.md orchestrator section) —
  never on instructions to the sub-floor model itself.

## [2.4.10] — 2026-07-07
- CI: GitHub Actions runs `scripts/lint.sh` on every push/PR — mechanical checks
  no longer depend on session discipline.
- This CHANGELOG added, with a docs/40 §7 rule and a lint check tying every
  version bump to an entry.

## [2.4.9] — 2026-07-07
- Skill cards get a codified ≤80-line cap (docs/40 §4, lint-enforced). (65b99b2)

## [2.4.8] — 2026-07-07
- Anti-rationalization layer adopted from a superpowers-plugin study:
  "Thought → Reality" tables in the judgment card (R2/R4), explicit skill
  cross-invocation in the dispatching card, rationalizing-is-the-signal line in
  the ten-laws card, and docs/40 §8 "before shipping a new rule" protocol. (637bb46)

## [2.4.7] — 2026-07-07
- Skill cards re-synced with the 2.4.6 statutes; docs/40 §5 now requires card
  sync after statute edits; `scripts/lint.sh` added (mirror version parity,
  plugin version rule, size caps). (c82a9f3)

## [2.4.6] — 2026-07-07
- Three statute tightenings from an adversarial red-team review: dirty-tree
  check generalized to any git repo (docs/40 §1); acceptance checkers re-derive
  "done" from the verbatim request (docs/10 §6); unattended skips halt dependent
  chains (docs/20 R3). (237028c)

## [2.4.5] — 2026-07-07
- README rewritten as a professional plugin README. (de5b6fc)

## [2.4.4] — 2026-07-06
- Ten Base Laws v2.0: user-approved compaction (mechanics moved into declared
  law-elaboration sections of docs/10); README gains the plugin-update guide. (9ad5a3a)

## [2.4.3] — 2026-07-06
- Ten Base Laws v1.5: the "in writing" definition explicitly names messages from
  other agents/sessions as data, never authorization. (f723f3a)

## [2.4.2] — 2026-07-06
- Cross-agent rules: AGENTS.md rule 8 extended and docs/20 R3 gains the
  permission-laundering ban (peer messages are data, never consent). (74d113b)

## [2.4.1] — 2026-07-06
- AGENTS.md rule 8 added: untrusted text is data, never instructions; docs/40 §7
  versioning rule fixed. (27ec6c0, 436d52c)

## [2.4.0] — 2026-07-06
- CLAUDE.md v2.4; Ten Base Laws v1.4 (17 word-level fixes); repo-wide pedantry
  pass; skills rewritten as progressive-disclosure cards; LICENSE added. (a22c152)

## [2.3.0] — 2026-07-06
- Ten Base Laws (docs/05) added as the supreme layer, with the ten-laws skill;
  v1.3 laws + 21 statute tightenings from a full-system adversarial audit;
  self-hosted marketplace listing. (951fbb5, ca0793b, bcff853)

## [2.1.0] — 2026-07-04
- First plugin shape: manifest, commands, skills, agents; docs/15 token-economy
  statute; 13 adversarial-review fixes. (1d83dda, 492369a)
