---
name: city-page-template
description: Structure for a city/location service page (e.g., /photo-booth-rental-mississauga). Use when adding ANY city or service-area page. Enforces uniqueness — each city page MUST have unique opening, unique venues list, and unique testimonial slot. Pages that duplicate other city pages get rejected.
---

Build a city page using this structure. The uniqueness rules are non-negotiable —
duplicate city pages hurt SEO instead of helping.

## Frontmatter

```yaml
---
title: "Photo Booth Rental in Mississauga | Eventsphere"
description: "Photo booth and 360 video booth rental in Mississauga. We've shot at [3 specific venues]. From $375. Same-day quote."
slug: "photo-booth-rental-mississauga"
city: "Mississauga"
region: "GTA West"
primaryKeyword: "photo booth rental mississauga"
heroImage: "../../assets/areas/mississauga-hero.jpg"
heroImageAlt: "Photo booth setup at [specific Mississauga venue]"
travelFee: 0  # or specific $ for outside-core areas
nearbyAreas: ["Brampton", "Oakville", "Etobicoke"]
ogImage: "/og/area-mississauga.jpg"
---
```

## Section structure

### 1. Hero
- H1: "Photo Booth Rental in [City]"
- Subhead: ONE city-specific sentence. Mention a recognizable venue,
  neighborhood, or local fact. NOT generic ("Capture memories in Mississauga").
  GOOD: "From the Living Arts Centre to backyard parties in Lorne Park,
  we've set up across Mississauga."
- CTA button: "Get a quote"

### 2. Recent events in this city (or city-specific intro paragraph)
- 2-3 sentences mentioning real venues you've worked at in this city
- If you haven't worked in this city yet but it's in your service area,
  flag it — don't fabricate venues. Use generic language about the area
  instead and update once a real event happens.

### 3. Both booth types available (short)
- Two cards: 360 booth + instant print booth
- Each links to its dedicated /booths/ page
- One sentence each in the context of THIS city
  (e.g., "Perfect for Mississauga corporate events at offices near
  Sheridan College" — only if true)

### 4. Pricing (consistent with /packages — don't duplicate, summarize)
- "Packages start at $375. See full [pricing](/packages)."
- Travel section: "Mississauga is within our core service area — no travel
  fee." OR "[City] is X km from Toronto — travel fee of $Y added to packages."

### 5. Local testimonial (REQUIRED — must be city-specific)
- A real testimonial from a client in this city
- Include: client first name, event type, venue/neighborhood, month/year
- If you don't have one, use a placeholder: `{{ NEEDS_TESTIMONIAL: <city> }}`
  and surface this in the build output so you know what to chase

### 6. Why [City] events specifically (1 short paragraph)
- Address something specific to this city's event scene
- Mississauga: "Mississauga venues often have generous indoor space, perfect
  for our 360 booth setup which needs a 10×10 ft footprint and 8 ft of ceiling."
- Don't reuse paragraphs across cities — the whole point is uniqueness

### 7. CTA
- Same primary CTA as other pages but phrased for this city
- "Book your Mississauga event"

## Uniqueness validation (mandatory before considering page done)

Run this check:
```bash
# Compare new city page to every existing city page
for f in src/content/areas/*.mdx; do
  if [ "$f" != "src/content/areas/<new-slug>.mdx" ]; then
    diff <(cat src/content/areas/<new-slug>.mdx) <(cat "$f") | wc -l
  fi
done
```

The diff output should be substantial — at least 60% of lines should differ.
If two city pages are 70%+ identical, they look like a doorway page to Google
and BOTH get penalized.

## What MUST be unique per city page

- Opening sentence (mentions a specific venue or local fact)
- "Recent events" paragraph
- Testimonial
- "Why [city] events" paragraph
- Travel section (different fee or text per area)

## What CAN be the same across city pages

- Pricing summary (links to single source on /packages)
- Booth type cards
- Final CTA wording (acceptable)
- Footer, header, schema scaffolding

## After page is built

- Invoke `seo-page-checklist`
- Add city to LocalBusiness `areaServed` if not already listed
- Add to sitemap (Astro sitemap integration handles this automatically)
- Add internal link from /contact page's service-area list
- If first page for a city, schedule a GBP post mentioning the new market
