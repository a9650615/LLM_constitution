---
description: Record a machine/environment pitfall into LESSONS.md (format-checked, deduplicated)
argument-hint: [what happened — or empty to extract the lesson from this conversation]
---

Record a pitfall so no future session steps on it again.

Input: $ARGUMENTS
(If empty: extract the most recent pitfall from this conversation — something that
was tried, failed for an environment-specific reason, and then solved another way.)

Steps:

1. Locate the log: `~/claude-ops/LESSONS.md` if it exists, else `LESSONS.md` at this
   plugin's root. Read its header and the last few entries.

2. Gate check — a lesson must have all three parts, otherwise don't record it:
   - Situation: what was being done
   - Wrong way: what was tried and the symptom
   - Right way: the correct steps (copy-pasteable command if possible)
   Generic tips ("grep has -r") are not lessons; only record what is specific to
   this machine/environment and likely to recur.

3. Dedup: Grep the file for related keywords. If an existing entry covers it,
   update that entry instead of appending a near-duplicate.

4. Append in the established format (`## L{n}. {one-sentence takeaway} ({date})`),
   English preferred. If the file now exceeds 40 entries or 250 lines, tell the
   user a compaction is due (do not compact without approval — that deletes rules).

5. If the file lives in a git repo, commit it (and push if that repo's docs
   pre-authorize pushing). Report to the user in one line what was recorded.
