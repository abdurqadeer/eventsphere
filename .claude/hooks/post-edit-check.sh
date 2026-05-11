#!/usr/bin/env bash
# PostToolUse hook: runs after any Edit or Write.
# Reads JSON from stdin (Claude Code hook protocol).
# Fast checks only — anything slow goes in /ship.

set -e

# Parse hook input
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty')

# Only act on src/, public/, .github/ paths
case "$FILE_PATH" in
  src/*|public/*|.github/*)
    ;;
  *)
    exit 0
    ;;
esac

# For image writes to public/, check size
if [[ "$FILE_PATH" == public/img/* ]] && [[ -f "$FILE_PATH" ]]; then
  SIZE=$(stat -f%z "$FILE_PATH" 2>/dev/null || stat -c%s "$FILE_PATH" 2>/dev/null || echo 0)
  if [ "$SIZE" -gt 300000 ]; then
    echo "::warning::Image $FILE_PATH is $(($SIZE / 1024))KB — should be < 300KB. Use Astro <Image> for auto-optimization." >&2
  fi
fi

# For source code edits, quick syntax check via Astro
if [[ "$FILE_PATH" == src/*.astro ]] || [[ "$FILE_PATH" == src/*.ts ]] || [[ "$FILE_PATH" == src/*.tsx ]]; then
  if command -v pnpm >/dev/null 2>&1; then
    if ! pnpm astro check --silent 2>&1 | tail -20; then
      echo "::error::pnpm astro check failed after editing $FILE_PATH" >&2
      exit 1
    fi
  fi
fi

# For MDX content edits, warn if missing frontmatter
if [[ "$FILE_PATH" == src/content/*.mdx ]]; then
  if ! head -1 "$FILE_PATH" 2>/dev/null | grep -q '^---$'; then
    echo "::warning::$FILE_PATH missing frontmatter. Use the relevant page template skill." >&2
  fi
fi

exit 0
