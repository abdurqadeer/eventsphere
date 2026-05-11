---
name: event-type-page-template
description: Structure for an event-type page (e.g., /weddings, /corporate-events). Use when adding any page that targets a specific event vertical. These pages capture the largest commercial-intent searches ("wedding photo booth rental toronto").
---

Build an event-type page. These are your highest-value SEO targets — they
match how people actually search.

## Frontmatter

```yaml
---
title: "Wedding Photo Booth Rental in Toronto & the GTA | Eventsphere"
description: "Wedding photo booth rental for Toronto & GTA weddings. 360 video booth + instant print. Custom templates. Book your date."
slug: "weddings"
eventType: "Wedding"
primaryKeyword: "wedding photo booth rental toronto"
heroImage: "../../assets/events/weddings-hero.jpg"
heroImageAlt: "Photo booth at a Toronto wedding reception"
ogImage: "/og/weddings.jpg"
---
```

## Section structure

### 1. Hero
- H1: "Wedding Photo Booth Rental in Toronto & the GTA"
- Subhead: Address what's specifically different about wedding photo booths
  vs. corporate or birthday. E.g., "Booths that work with your reception
  timeline, not against it."
- CTA: "Check our date" → /contact (calendar-aware language for weddings)

### 2. What weddings need from a photobooth (3 paragraphs)
- Para 1: Timeline awareness. Photographers go to dinner, the booth picks
  up the slack during cocktails and dancing.
- Para 2: Take-home keepsakes matter at weddings — guests want a strip
  with the bride/groom's names on it.
- Para 3: Setup that doesn't compete with your decor.
- These should be NEW writing, not lifted from booth pages.

### 3. Both booth types in a wedding context
- 360 video booth at a wedding: dance floor energy, social shares
- Instant print at a wedding: keepsake strip with custom template

### 4. Wedding-specific packages
- Pull from /packages but frame them for weddings:
  "Most weddings book our 4-hour Platinum package — covers cocktail hour
  through the dance floor"
- 1-line recommendation

### 5. Recent wedding events
- Embed fotoshare gallery filtered to weddings (if supported), or grid
  of 6 best wedding shots
- Lazy-loaded

### 6. Wedding FAQ (5-8 questions)
- When should we book? (6-12 months out for peak season May-October)
- Do you do destination weddings? (Travel fee applies beyond X km)
- Can the template include our names and date? (Yes, free)
- What if our reception runs late? (Overtime rate $X/hour)
- Do you need a meal? (Yes if booth is on-site 5+ hours)
- Where do you set up? (10×10 ft minimum, near power, not directly on the
  dance floor)
- What about guest privacy? (Optional — we don't post any images publicly
  without permission)
- Wrap in FAQPage JSON-LD via `faq-schema` skill

### 7. Real wedding testimonials
- 2-3 testimonials from actual weddings
- Include: bride/groom first names, venue, month/year
- If you have <2, surface that and use a single hero quote until more arrive

### 8. CTA
- "Tell us your wedding date" → /contact
- This wording is different from booth pages' "Get a quote"

## What NOT to put on an event-type page

- Generic company history (link to /about instead)
- Pricing tables (link to /packages — keep one source of truth)
- Other event types (link to them)
- Stock-feeling copy ("Your special day deserves...")

## SEO mandatory

- Primary keyword in H1, first paragraph, one H2, slug, meta description
- Use variations naturally: "wedding photobooth", "photo booth for weddings",
  "wedding booth rental"
- Internal links to: both booth pages, /packages, /gallery, /contact
- Service schema with `serviceType: "Wedding photo booth rental"`,
  `audience: { @type: 'Audience', audienceType: 'Engaged couples' }`
- Invoke `seo-page-checklist` before done
