---
name: meta-tag-writer
description: Generates title tag, meta description, OG tags, and Twitter card for any page. Use when creating a new page or when seo-page-checklist flags missing/poor metadata. Takes the page's H1 and primary keyword as input.
---

Generate complete metadata for a page.

## Process

Read the page's frontmatter and content. Generate:

### Title tag (50-60 characters)

Pattern options:
- `[Primary keyword] in [City] | [Brand]` — best for service pages
- `[Brand] — [Tagline or category]` — for home page only
- `[Question being answered] | [Brand]` — for blog posts

Examples:
- "360 Video Booth Rental in Toronto & the GTA | Eventsphere" (59 chars ✓)
- "Wedding Photo Booth Rental in Toronto | Eventsphere" (51 chars ✓)
- "Eventsphere — Toronto & GTA Photo Booth Rental" (47 chars ✓)

Anti-patterns to avoid:
- Title under 30 chars (wastes the slot — Google rewards specific titles)
- Title over 65 chars (truncated in search results)
- Title starting with brand name on non-home pages (wastes prime real estate)
- Title with no location keyword on a local-service page
- Duplicate title across pages (every page must be unique)

### Meta description (140-160 characters)

Pattern: hook + key facts + implicit CTA, no period ending mid-sentence
when truncated.

Examples (count characters):
- "Rent a 360° video booth in Toronto & the GTA. Slow-motion video, custom
  overlays, instant digital sharing. From $400. Book your date." (143 chars ✓)
- "Wedding photo booth rental for Toronto & GTA weddings. 360 video booth +
  instant print. Custom templates with your names. Get a quote." (147 chars ✓)

Anti-patterns:
- Generic platitudes ("Capture memories with our state-of-the-art booth")
- No specific facts (no price, no location, no service detail)
- Ending mid-sentence (write to fit 145-155 chars comfortably)
- Starting with "Welcome to..." (waste of pixels)

### OpenGraph tags

```html
<meta property="og:type" content="website" />
<meta property="og:url" content="<absolute canonical URL>" />
<meta property="og:title" content="<can match title or be shorter>" />
<meta property="og:description" content="<can match meta description>" />
<meta property="og:image" content="<absolute URL to 1200x630 image>" />
<meta property="og:image:width" content="1200" />
<meta property="og:image:height" content="630" />
<meta property="og:site_name" content="Eventsphere Photobooths" />
<meta property="og:locale" content="en_CA" />
```

### Twitter card

```html
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="<same as og:title>" />
<meta name="twitter:description" content="<same as og:description>" />
<meta name="twitter:image" content="<same as og:image>" />
```

## OG image rules

- 1200×630 px exactly (other sizes get downscaled and look bad)
- Under 300KB (Facebook caches them — heavier images get rejected)
- Brand colors, brand logo visible, page-specific imagery
- If page-specific OG image doesn't exist, use the default at /og/default.jpg
- Generate page-specific OG images for the home page, each booth page, and
  each event-type page — these are what show up when people share links
  in WhatsApp groups

## Output

Update the page's frontmatter with the new title and description. Generate
the OG/Twitter tags into the Layout component if not already there.
Confirm character counts. Don't ship metadata you haven't counted.

## Quick character-counter

```bash
echo -n "Your title here" | wc -c
```

If over 60, trim. Common trims: drop "Rental" (implied), drop "the" before
"GTA", abbreviate "Greater Toronto Area" to "GTA".
