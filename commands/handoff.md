---
description: Write a handoff file so a successor session can continue this work without re-deriving context
argument-hint: [optional: where to write it; default HANDOFF.md in the working directory]
---

The session may be about to die (context exhaustion, quota, interruption). Write a
handoff that lets a cold-started successor — possibly a weaker model — continue
without re-deriving anything.

Write to: $ARGUMENTS (default: `HANDOFF.md` in the current working directory;
if not writable, the session scratchpad — then tell the user the path out loud).

Contents, in this order (be concrete; paths and commands, not vibes):

1. **Goal** — the user's original request, verbatim where possible.
2. **Done & verified** — each finished item with its evidence (file:line, test
   output, commit hash). Only items that were actually verified; anything else
   goes in 4.
3. **In flight** — what is half-done right now, which files are touched,
   what state they're in.
4. **Unverified / uncertain** — claims made but not checked, known risks.
5. **Failure trails** — approaches already tried that failed, with verbatim
   errors. This is what saves the successor from repeating them.
6. **Next steps** — ordered, first step executable immediately
   (exact command or file to open).

Then: if the working directory is a git repo with uncommitted work, say so in the
handoff and (unless the user said otherwise) leave the tree as-is — the successor
decides. Finally, report the handoff path to the user as the last line.
