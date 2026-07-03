# 40 — Maintenance protocol: how to update this institution safely

Version 2.0 (2026-07-03). Canonical (English); 中文鏡像 `zh/40-maintenance.md`.
Audience: future models of any tier. The value of these files is *stable accumulation*;
the biggest risk is well-meaning edits slowly ruining them (degradation modes:
`docs/90-letter.md`).

## 1. Before editing: snapshot

`~/claude-ops` is a git repo. Before editing any existing file here:

```bash
cd ~/claude-ops && git add -A && git commit -m "pre-edit snapshot" -q
```

After the edit passes verification (§5), commit again with a real message describing
the change. If git is somehow unavailable, fall back to:

```bash
mkdir -p ~/claude-ops/backups
cp "{file}" ~/claude-ops/backups/"{name}.$(date +%Y%m%d-%H%M%S).bak"
```

(`backups/` >20 files → delete the oldest `.bak` files; the only deletion that needs
no asking.)

## 2. Permission levels

### You may change on your own (verifier read-back after; tell the user afterwards)

- **Appending** a new lesson to `LESSONS.md` (format: §3). The most common and most
  welcome maintenance.
- **Fixing facts proven wrong**, anywhere: a referenced path is dead, a command was
  renamed, the environment changed (e.g. proxy moved ports). Condition: attach the
  verification evidence (actual command output); change only that fact.
- **Updating `BINDINGS.md`** when reality has moved (new model names, changed tool
  surface) — that file exists precisely to absorb this rot. Bump its "last verified"
  date; keep evidence.
- **Adding blanks or examples to templates** (`docs/30-templates.md`) without touching
  existing section structure.

### Ask the user first (present: current text → proposed text + reason)

- Changing or deleting the **three core laws** (CLAUDE.md) or the **hard ask-first
  list** (`docs/20-judgment.md` R3).
- Changing **threshold numbers** in `docs/10-dispatch.md` (files-before-delegating,
  retry counts, tier defaults) — these were deliberately calibrated; one session's
  experience is not enough to overturn them.
- **Deleting** any rule (adding restrictions needs no asking; loosening does).
- Changing the global `~/.claude/CLAUDE.md` or `~/.claude/agents/` (affects every session).
- Large-scale restructuring of the file layout.

## 3. Where lessons go, in what format

**Machine/environment pitfalls** → append to `~/claude-ops/LESSONS.md`:

```markdown
## L{n}. {one-sentence takeaway} ({YYYY-MM-DD})
- Situation: what you were doing
- Wrong way: what was tried, what the symptom was
- Right way: the correct steps (copy-pasteable commands if possible)
```

New entries preferably in English (cheaper tokens); Chinese acceptable — format
matters more than language.

**User preferences & long-lived cross-project facts** → memory (the harness memory
mechanism), not LESSONS.md. **Single-repo pitfalls** → that repo's own CLAUDE.md,
not here.

## 4. When to compact

- `LESSONS.md` over **40 entries or 250 lines** → propose compaction: merge
  duplicates, delete obsolete ones, "promote" recurring lessons into the matching
  docs/ file (then delete the originals). Compaction deletes rules → ask the user first.
- Any docs/ file over **250 lines** → same: propose compaction to the user.
- `CLAUDE.md` (master) stays within **one page (≤80 lines)** forever: new content
  goes into docs/, CLAUDE.md gets only a routing line.

## 5. After editing

1. Dispatch `verifier` for a read-back: file complete; every referenced path and name
   still actually exists.
2. Tell the user what changed (one line is enough).
3. If the change affects cross-references (renamed file, renumbered section), Grep
   `~/claude-ops/` and update every reference in the same session.
4. Commit (§1).

## 6. Language policy (canonical vs mirror)

- **Canonical = the English files**: `CLAUDE.md`, `docs/10–40`, `BINDINGS.md`,
  `AGENTS.md`. Every content edit lands here first. On any conflict, English wins.
- **`zh/` mirrors** exist for the user's reading. After editing a canonical file,
  update its mirror in the same session if quick; otherwise just bump the canonical
  version stamp — the mirror header names the version it mirrors, so lag stays
  visible. **Never edit a zh mirror alone.** A session may regenerate any mirror from
  the canonical file on request.
- `docs/00-diagnosis.md` and `docs/90-letter.md` are archival Chinese: append-only
  (handoff notes), never translated, never rewritten.

## 7. Version stamps

Every canonical file's header carries `Version: X.Y (date)`. Bump on every content
edit (Y+1 for fixes/additions; X+1 for structural change, ask-user class). Mirrors
carry "mirrors en vX.Y" in their header. A mirror whose number lags its canonical is
stale by definition — trust the English file.
