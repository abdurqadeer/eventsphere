---
name: service-page-template
description: Canonical structure for a booth-type service page (e.g., /booths/360-video-booth). Use when creating or updating any page under src/content/booths/. Ensures every booth page has the same sections and full SEO scaffolding.
---

Build a booth-type service page using this exact structure. Skip nothing.

## Frontmatter

```yaml
---
title: "360 Video Booth Rental in Toronto & the GTA | Eventsphere"
description: "Rent a 360° video booth in Toronto & the GTA. Slow-motion video, custom overlays, instant digital sharing. From $400. Book your date."
slug: "360-video-booth"
primaryKeyword: "360 video booth rental toronto"
heroImage: "../../assets/booths/360-hero.jpg"
heroImageAlt: "360 video booth in action at a Toronto wedding"
priceFrom: 400
priceCurrency: "CAD"
serviceType: "360 photo booth rental"
schema:
  type: "Service"
ogImage: "/og/360-booth.jpg"
---
```

## Section structure

### 1. Hero
- H1 matching frontmatter title pattern
- One-sentence subhead — what makes this booth specifically fun/different
- Primary CTA button: "Get a quote" → /contact
- Hero image (LCP image — preloaded, AVIF, sized to viewport)
- NO autoplay video on mobile (poster image only, video on click)

### 2. Three-feature strip
- 3 concrete benefits with icons
- Each: short headline + one-sentence support
- E.g., "Instant social shares" / "60-second slow-mo videos" / "Custom branded overlays"

### 3. What's included (specific to this booth)
- Bulleted list, concrete items only
- For 360: unlimited recordings, custom overlay, on-site attendant,
  professional lighting, digital sharing station, props
- For print: unlimited 2×6 or 4×6 prints, custom template with your logo/event
  name, professional lighting, props, on-site attendant, digital sharing

### 4. How it works at your event (3-step walkthrough)
- "We arrive 60 minutes before the booth starts"
- "Guests step in / step on, choose a backdrop or template"
- "They get their video/print on the spot, plus digital copy by SMS or email"
- Each step: 2-3 sentences. Concrete. No fluff.

### 5. Sample work
- Embed the fotoshare gallery for a recent event using this booth type
- OR a 2×2 grid of best shots/clips (lazy-loaded)

### 6. Pricing
- Table with all package tiers (Silver/Gold/Platinum or equivalent)
- Real prices from CLAUDE.md
- What's included per tier
- "What's NOT included" line if applicable (travel beyond X km, overtime rates)
- Single primary CTA below: "Check our availability" → /contact

### 7. FAQ (5-8 questions specific to this booth type)
- For 360: How much space do we need? Can you brand the overlay? What if our
  venue has low ceilings? Can guests text themselves the video? Do you need
  internet access? How long are the videos?
- For print: 2×6 or 4×6? Can we customize the template with our logo? How
  many prints per session? Unlimited reprints? What if we run out of paper?
- Wrap in FAQPage JSON-LD using the `faq-schema` skill

### 8. Other booth types (internal linking)
- One short paragraph + link: "Looking for [other booth]? See our
  [Instant Print Photobooth](/booths/instant-print-booth)."

### 9. Final CTA
- Repeat primary CTA — different angle than hero
- E.g., "Booking 3-6 months ahead. Send us your date and we'll confirm
  availability the same day."

## SEO mandatory checks

After page is drafted, before considering it done:
- Invoke `meta-tag-writer` skill to finalize title and description
- Invoke `faq-schema` skill for the FAQ block
- Invoke `seo-page-checklist` skill for final validation
- Build with `pnpm build` and confirm raw HTML contains H1 and at least
  first paragraph (test with `curl -s http://localhost:4321/booths/<slug>/ | grep -c '<h1'`)

## What NOT to put on a booth page

- Generic "Why choose us" puffery (covered by /about)
- Full company history (covered by /about)
- Other event types in depth (link to /weddings, /corporate-events instead)
- Multiple CTAs in the hero — one only
