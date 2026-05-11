---
name: audit
description: Full-site audit. Runs seo-auditor, schema-validator, lighthouse-runner, and accessibility-checker against every page in sitemap. Use weekly or after major changes. Produces a single report.
---

Audit the entire site.

## Steps

1. Read `dist/sitemap-index.xml` or `dist/sitemap-0.xml` to get the list
   of pages. If no build exists, run `pnpm build` first.
2. For each page in the sitemap:
   - Invoke `seo-auditor` subagent
   - Invoke `schema-validator` subagent
   - (skip Lighthouse per page — too slow; run on home + 3 key pages only)
3. Run `lighthouse-runner` against: /, /booths/360-video-booth,
   /booths/instant-print-booth, /weddings
4. Run `accessibility-checker` against: /, /contact, /packages, /weddings

## Output: a single audit report

```
## Site audit — <date>

### Coverage
- Pages in sitemap: 14
- Pages audited: 14
- Pages with no issues: 11

### Issues by page

/photo-booth-rental-mississauga
- [SEO] Meta description 89 chars (target 140-160)
- [Schema] Missing Service schema

/gallery
- [PERF] LCP 3.1s on mobile (target <2.5s) — too many iframes above fold

### Cross-site issues
- 3 city pages share >40% identical text — risk of doorway page penalty
- og:image is using default fallback on 6 pages — generate page-specific images

### Scores summary (home page)
Mobile: P=88 SEO=100 A11Y=100 BP=100
Desktop: P=97 SEO=100 A11Y=100 BP=100

### Recommended next actions (in priority order)
1. Fix Mississauga page metadata (5 min)
2. Generate OG images for the 6 pages using defaults (30 min)
3. Reduce fold iframes on /gallery (1 hour)
4. Differentiate city pages — content uniqueness (2 hours, content work)
```

## Rules

- This is a read-only audit — don't fix issues during /audit (that would
  bloat the report). Surface them. The user picks what to fix and when.
- Don't audit pages outside the sitemap (legal pages might intentionally
  be noindex)
- If the report would be >150 lines, summarize and offer to dive into
  specific pages
- Save the report to `docs/audits/<date>.md` so we have a trail
