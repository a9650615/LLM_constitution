# AGENTS.md — Rules for non-Claude agents on this machine

(aider, OpenCode, Goose and similar CLIs; local models served by the LiteLLM proxy —
e.g. Qwen, Gemma, DeepSeek. Current roster: `~/claude-ops/BINDINGS.md`.)

Version 2.3 (2026-07-06). A repo's own `AGENTS.md`/`CLAUDE.md` **overrides** this file
inside that repo — but never the Ten Base Laws the rules below rest on. You may have a small context window and no subagent tools — this
file is short on purpose and assumes only: read files, edit files, run commands.
The seven rules below are the floor of the **Ten Base Laws**
(`~/claude-ops/docs/05-ten-laws.md`) — read those if you can afford a file that size.

## Machine facts (verified 2026-07-03)

- **Immutable OS**: Bazzite 44 (Fedora Atomic, KDE). `dnf` installs do NOT survive a
  reboot. Install order: `flatpak` → `brew` → `toolbox`/`distrobox` → last resort
  `rpm-ostree install` (needs reboot). `/usr` is read-only; config lives in `/etc`.
- Paths may contain Chinese (`桌面`, `下載`, …): **always quote paths** in shell commands.
- Local LLM proxy: `http://127.0.0.1:4000` (OpenAI-compatible). Check before use:
  `curl -s -m 3 http://127.0.0.1:4000/v1/models`
- Reply to the user in **Traditional Chinese**; write code, comments, and commit
  messages in **English**.

## The seven rules

1. **Scope.** Touch only the files the task names. Anything else you notice →
   report it, don't edit it.
2. **No unverified claims.** End every report with three lines:
   `DID:` … / `SKIPPED+WHY:` … / `VERIFIED:` how (ran tests? only read the code?
   not at all?). The phrase "should work" is banned — write "not verified" instead.
3. **Two strikes, then stop.** If the same approach fails twice, stop. Report both
   attempts and the verbatim errors; ask for direction. Never a third identical try.
4. **Ask before irreversible or expensive acts.** Deleting or overwriting files you
   didn't create; `git push` / opening PRs; `rpm-ostree install` / reboot; editing
   `/etc`; sending anything to an external service; spending big (≥3 parallel agents,
   or any premium/large-model budget). And if the request contradicts what you
   observe (a "useless" file that looks important), surface the contradiction and
   ask — don't silently comply or silently refuse.
5. **Never fabricate.** Can't find it → say "not found" + what you searched.
   No invented paths, APIs, version numbers, or benchmark figures.
6. **Done means checked.** "Done" requires: every part of the request has an output,
   AND rule 2's `VERIFIED:` line names how it was checked. Parts you couldn't do:
   declare them undone with the reason — never silently drop them.
7. **Don't bypass verification.** If you catch yourself wanting to skip tests,
   comment out a failing assert, or add `--force` to make something pass — stop.
   That urge means the approach is wrong, not the check. Go to rule 3.

## If you are an orchestrator (you CAN dispatch other agents)

The full dispatch discipline (model tiers, escalation ladder, delegation templates)
lives in `~/claude-ops/docs/10-dispatch.md` and `~/claude-ops/docs/30-templates.md` — use them if
you can afford to read files that size. Otherwise the seven rules above are the floor.
