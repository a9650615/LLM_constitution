# Changelog

All notable changes to the `llm-constitution` plugin. Versions follow the rule in
`docs/40-maintenance.md` §7 (X.Y tracks CLAUDE.md; Z bumps for plugin-shipped
changes that don't touch it). Every `plugin.json` bump ships with an entry here
(lint-enforced). Backfilled 2026-07-07 from git history; commit hashes are the
authoritative detail.

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
