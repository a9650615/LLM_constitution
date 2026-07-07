#!/usr/bin/env bash
# lint.sh — mechanical institution checks (docs/40-maintenance.md §5 step 1).
# Deterministic half of verification: mirror version parity, plugin version rule
# (docs/40 §7), size caps (docs/40 §4). Semantic checks stay with the verifier.
# Exit 0 = clean; exit 1 = findings printed as FAIL lines.
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0
err() { printf 'FAIL: %s\n' "$*"; fail=1; }

en_ver() { grep -oE 'Version [0-9]+\.[0-9]+' "$1" | head -1 | cut -d' ' -f2; }
zh_ver() { grep -oE '鏡像 en v[0-9]+\.[0-9]+' "$1" | head -1 | grep -oE '[0-9]+\.[0-9]+'; }

# 1. EN canonical ↔ zh mirror version parity (docs/40 §6-§7)
for pair in \
  "CLAUDE.md zh/CLAUDE.md" \
  "docs/05-ten-laws.md zh/05-ten-laws.md" \
  "docs/10-dispatch.md zh/10-dispatch.md" \
  "docs/15-token-economy.md zh/15-token-economy.md" \
  "docs/20-judgment.md zh/20-judgment.md" \
  "docs/30-templates.md zh/30-templates.md" \
  "docs/40-maintenance.md zh/40-maintenance.md"; do
  set -- $pair
  [ -f "$1" ] || { err "$1: missing canonical file"; continue; }
  [ -f "$2" ] || { err "$2: missing mirror file"; continue; }
  en=$(en_ver "$1"); zh=$(zh_ver "$2")
  [ -z "$en" ] && err "$1: no 'Version X.Y' header"
  [ -z "$zh" ] && err "$2: no '鏡像 en vX.Y' header"
  if [ -n "$en" ] && [ -n "$zh" ] && [ "$en" != "$zh" ]; then
    err "mirror lag: $1 is v$en but $2 mirrors v$zh"
  fi
done

# 2. plugin.json version tracks CLAUDE.md major.minor as X.Y.Z (docs/40 §7)
claude=$(en_ver CLAUDE.md)
plugin=$(grep -oE '"version"[[:space:]]*:[[:space:]]*"[0-9]+\.[0-9]+\.[0-9]+"' \
  .claude-plugin/plugin.json | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
[ -z "$plugin" ] && err ".claude-plugin/plugin.json: no X.Y.Z version found"
case "$plugin" in
  "$claude".*) ;;
  *) [ -n "$plugin" ] && err "plugin.json v$plugin does not track CLAUDE.md v$claude (rule: docs/40 §7)" ;;
esac
if [ -n "$plugin" ]; then
  grep -q "^## \[$plugin\]" CHANGELOG.md 2>/dev/null || \
    err "CHANGELOG.md has no entry for v$plugin (rule: docs/40 §7)"
fi

# 3. Size caps (docs/40 §4); archival docs/00 and docs/90 exempt
for f in CLAUDE.md AGENTS.md zh/CLAUDE.md; do
  n=$(wc -l < "$f")
  [ "$n" -gt 80 ] && err "$f: $n lines (cap 80)"
done
for f in docs/[0-9]*.md zh/[0-9]*.md; do
  case "$f" in docs/00-*|docs/90-*) continue ;; esac
  n=$(wc -l < "$f")
  [ "$n" -gt 250 ] && err "$f: $n lines (cap 250)"
done
for f in skills/*/SKILL.md; do
  n=$(wc -l < "$f")
  [ "$n" -gt 80 ] && err "$f: $n lines (cap 80, docs/40 §4)"
done

[ "$fail" -eq 0 ] && echo "lint OK"
exit "$fail"
