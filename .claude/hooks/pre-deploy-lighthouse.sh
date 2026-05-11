#!/usr/bin/env bash
# PreToolUse hook on Bash: blocks deploys if quality gates fail.
# Reads JSON from stdin.

set -e

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Only act on deploy-like commands
case "$COMMAND" in
  *"vercel --prod"*|*"vercel deploy --prod"*|*"git push origin main"*)
    ;;
  *)
    exit 0
    ;;
esac

echo "Pre-deploy guard: running quality gates..." >&2

# Build must succeed
if ! pnpm build 2>&1 | tail -5; then
  echo "::error::Build failed. Cannot deploy." >&2
  exit 2
fi

# Lighthouse must pass on the locally-served build
pnpm preview &
PREVIEW_PID=$!
sleep 3

LH_RESULT=$(npx lighthouse http://localhost:4321 \
  --preset=perf \
  --form-factor=mobile \
  --output=json \
  --output-path=/tmp/lh-deploy.json \
  --chrome-flags="--headless --no-sandbox" \
  --quiet 2>&1 | tail -5)

kill $PREVIEW_PID 2>/dev/null || true

# Extract scores
LCP=$(jq -r '.audits."largest-contentful-paint".numericValue' /tmp/lh-deploy.json)
SEO=$(jq -r '.categories.seo.score * 100' /tmp/lh-deploy.json)
A11Y=$(jq -r '.categories.accessibility.score * 100' /tmp/lh-deploy.json)

LCP_INT=${LCP%.*}

if [ "$LCP_INT" -gt 2500 ]; then
  echo "::error::Mobile LCP is ${LCP}ms (budget: 2500ms). Cannot deploy." >&2
  exit 2
fi

if [ "${SEO%.*}" -lt 100 ]; then
  echo "::error::SEO score is ${SEO} (must be 100). Cannot deploy." >&2
  exit 2
fi

if [ "${A11Y%.*}" -lt 95 ]; then
  echo "::error::Accessibility score is ${A11Y} (must be ≥95). Cannot deploy." >&2
  exit 2
fi

echo "Pre-deploy guard: PASS (LCP=${LCP}ms, SEO=${SEO}, A11Y=${A11Y})" >&2
exit 0
