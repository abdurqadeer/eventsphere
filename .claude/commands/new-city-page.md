---
name: new-city-page
description: Scaffold a new city/service-area page. Use when expanding to a new service area. Invokes the city-page-template skill, generates the file, and enforces uniqueness vs existing city pages.
---

Scaffold a new city page.

## Usage

```
/new-city-page <city-name>
```

Example: `/new-city-page Burlington`

## Process

1. Confirm the city is actually in the service area. Check CLAUDE.md.
   If it's a new area not yet listed there, ask the owner first — adding
   areas you don't actually service is a GBP compliance risk.
2. Generate slug: `photo-booth-rental-<city-lowercased-and-hyphenated>`
3. Invoke `city-page-template` skill to get the structure
4. Generate the file at `src/content/areas/<slug>.mdx`
5. Use placeholder for testimonial: `{{ NEEDS_TESTIMONIAL: <city> }}`
6. Use placeholder for venues if no real history yet:
   `{{ NEEDS_VENUES: <city> — add when first event runs }}`
7. Run uniqueness check (diff against every other src/content/areas/*.mdx)
8. Invoke `seo-page-checklist` skill for SEO scaffolding
9. Update `src/lib/schema/localBusiness.ts` to add the city to `areaServed`
   if not already there
10. Add the city to `/contact` page's service-area list
11. Surface the TODOs that need human input (testimonial, venues, etc.)

## Output

```
Created src/content/areas/photo-booth-rental-burlington.mdx

TODOs requiring owner input:
- Add a real testimonial from a Burlington client (or remove the section)
- Add 2-3 specific venues you've worked at in Burlington
- Confirm travel fee for Burlington (currently set to $0 — same as core GTA)

Updated:
- src/lib/schema/localBusiness.ts (added Burlington to areaServed)
- src/pages/contact.astro (added to service-area list)

Next: review the file, fill in the TODOs, then run /ship.
```

## Rules

- Never auto-generate a fake testimonial
- Never fabricate venue history
- Always run the uniqueness check — if the new page is >70% similar to
  another, refuse to create it and explain why
- Never add a city to areaServed schema without confirming actual service
