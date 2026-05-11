#!/usr/bin/env bash
# Runs at the start of every Claude Code session.
# Surfaces current state so the agent doesn't have to ask.

set -e

cat <<EOF
=== Eventsphere session start ===

Branch:    $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no git")
Last log:  $(git log -1 --oneline 2>/dev/null || echo "no commits yet")
Uncommit:  $(git status --porcelain 2>/dev/null | wc -l | tr -d ' ') file(s)

EOF

# If there's a last Lighthouse report, surface its summary
if [ -f /tmp/lh-mobile-summary.txt ]; then
  echo "Last Lighthouse (mobile):"
  cat /tmp/lh-mobile-summary.txt
  echo
fi

# Surface any TODOs marked in code with @todo or // TODO(seo)
TODO_COUNT=$(grep -r --include='*.{ts,tsx,astro,mdx,md}' -E '(TODO\(seo\)|@todo:seo)' src 2>/dev/null | wc -l | tr -d ' ' || echo 0)
if [ "$TODO_COUNT" != "0" ]; then
  echo "SEO TODOs in code: $TODO_COUNT"
  grep -r --include='*.{ts,tsx,astro,mdx,md}' -nE '(TODO\(seo\)|@todo:seo)' src 2>/dev/null | head -5
  echo
fi

# Remind about the roadmap
echo "Reminder: docs/ROADMAP.md is the source of truth for sprint priorities."
echo "Run /audit weekly. /ship before any merge."
