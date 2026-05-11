---
name: ship
description: Run the full pre-merge quality gate. Use before opening a PR or merging to main. Chains lint, type check, build, Lighthouse, schema validation, and accessibility audit.
---

Run the full quality gate. Stop on first failure.

## Steps

1. **Lint**: `pnpm lint` — must exit 0
2. **Type check**: `pnpm astro check` — must exit 0 with no errors
3. **Build**: `pnpm build` — must exit 0
4. **Static render verification**: for the changed pages (use `git diff --name-only`
   to find which content/pages were touched), verify the H1 appears in the
   built HTML:
   ```bash
   for page in $changed_pages; do
     grep -c '<h1' dist/$page/index.html || echo "FAIL: $page"
   done
   ```
5. **Schema validation**: start preview, invoke `schema-validator` subagent
   against the changed pages
6. **Lighthouse (mobile + desktop)**: invoke `lighthouse-runner` subagent
   against the home page and any changed pages
7. **Accessibility**: invoke `accessibility-checker` subagent against the
   same pages

## Output format

```
## /ship results

✅ Lint
✅ Type check
✅ Build (3.4s)
✅ Static render (4 pages verified)
✅ Schema (3 pages validated, all clean)
⚠ Lighthouse: home page mobile LCP=2.7s (budget 2.5s)
✅ Accessibility

Status: BLOCKED — fix the LCP issue before merge.
Suggested fix: hero image is 380KB, optimize to AVIF ~80KB.
```

If everything green:
```
## /ship results

All checks passed. Ready to open PR.
```

## Rules

- Don't merge or deploy if any step fails — surface the issue and stop
- Don't suppress warnings; surface them and let the user decide
- After a passing /ship, suggest the next step: "Open a PR with: gh pr create
  --title '...' --body '...'"
