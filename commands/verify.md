---
description: Dispatch a fresh-context verifier against explicit acceptance criteria (never self-verify)
argument-hint: [what to verify + criteria; empty = verify the last task claimed done]
---

Run a fresh-context acceptance check. Core law: the context that produced work must
not be the context that accepts it.

Target: $ARGUMENTS
(If empty: the most recent task in this conversation that was claimed done or is
about to be claimed done.)

Steps:

1. Write down the acceptance criteria as mechanically checkable items. Sources, in
   order: criteria stated in $ARGUMENTS → the user's original request for that task
   (re-read it, clause by clause) → for code, "existing tests stay green + changed
   behavior exercised at least once". Never use "looks good" as a criterion. Always
   append: "every referenced path/command/name actually exists".

2. Dispatch the check to a fresh subagent — `verifier` if the harness knows it,
   otherwise `general-purpose` with read-only instructions. Give it ONLY: the
   verbatim original request, the criteria list, and the file paths / diff range /
   test commands. Do NOT describe how the work was produced — fresh context is the
   whole point. Instruct it to verdict each criterion pass / fail / unverifiable
   with evidence (`path:line` or key output line), and to fix nothing.

3. Relay the verdict table to the user unedited. If anything failed: that counts as
   a failed attempt for escalation purposes — fix and re-verify, or if this was
   already the second failure of the same approach, change approach instead of
   retrying (constitution: docs/20-judgment.md R4).

Never report the task as done while any criterion is failed or unverifiable without
saying so explicitly.
