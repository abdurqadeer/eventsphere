---
name: seo-page-checklist
description: Validates on-page SEO for any Astro page or MDX content file. Auto-invokes after edits to src/pages/ or src/content/. Use after adding a new page or before considering any page change "done". Checks title, meta, schema, headings, alt text, internal linking, and static-render correctness.
---

When invoked, run this checklist against the page in question. Fix what's
missing. Report what passed and what was fixed.

## Checklist

1. **Title tag** — 50-60 chars, includes primary keyword + location + brand
   Pattern: `[Keyword] in [City] | [Brand]` or similar
2. **Meta description** — 140-160 chars, includes implicit CTA, doesn't end
   mid-sentence, doesn't start with the brand name (waste of pixels)
3. **Canonical** — present, absolute URL, matches intended path
4. **OpenGraph** — og:title, og:description, og:image (absolute, ~1200×630,
   < 300KB), og:type, og:url
5. **Twitter card** — `summary_large_image` with same image
6. **Single H1** — present, unique on page, contains primary keyword naturally
7. **H2 hierarchy** — no skipped levels, descriptive (not "Section 1")
8. **Images** — every `<Image>` has descriptive `alt`; decorative images use
   `alt=""`; non-decorative `alt` mentions context (event type, city) where
   natural — but never keyword-stuffed
9. **Internal links** — at least 2-3 contextual links to related pages with
   descriptive anchor text
10. **Schema** — appropriate JSON-LD present: LocalBusiness on home, Service
    on booth pages, Event/FAQPage where applicable
11. **Static render check** — after running `pnpm build`, verify the H1 and
    primary copy are in the raw HTML:
    ```bash
    pnpm build && grep -c '<h1' dist/<page-path>/index.html
    ```
    Must return ≥ 1.
12. **Lighthouse SEO score** — invoke `lighthouse-runner` subagent against
    the built page; SEO must be 100, A11Y ≥ 95

## Output

```
## SEO checklist — <page>

Passed: 1, 3, 4, 5, 6, 7, 9, 11
Fixed: 2 (meta description was 89 chars, expanded to 152)
Fixed: 8 (added alt to hero image: "360 photo booth at Toronto wedding")
Fixed: 10 (added Service schema)
Failed (needs human): none

Lighthouse: SEO=100 A11Y=98 (mobile)
```

## Rules

- Never invent values to satisfy a check. If meta description requires
  human input (claims about pricing, dates, etc.), flag it and ask.
- For city pages, also verify uniqueness — pull the other city pages and
  check that the new page doesn't share more than 30% of text with any
  existing city page (use diff/wc to measure roughly).
- If a check requires running the build, do so. Don't skip checks 11-12.
