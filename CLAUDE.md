# Eventsphere Photobooths — Project Memory

## What this is

Marketing site + lead-generation for **Eventsphere Photobooths**, a photobooth
rental business serving the **Greater Toronto Area** (primary) and **Ottawa**
(secondary). Replaces the existing React + Vite SPA at
`eventspherephotobooths.com`, which is invisible to search engines and AI
assistants because all content renders client-side.

Brand name: **Eventsphere** (one word, capital E). Never "Events Sphere".

## Business facts (use these in copy and schema)

- **Service areas**: Toronto, Mississauga, Vaughan, Markham, Brampton,
  Richmond Hill, Oakville, Burlington, Scarborough, Etobicoke, North York,
  and the wider GTA. Ottawa is a secondary market with its own Instagram
  presence. Travel beyond these areas available for a fee.
- **Services offered**:
  - 360° Video Booth (slow-motion video, custom overlays, digital sharing)
  - Instant Print Photobooth (DSLR, professional lighting, 2×6 or 4×6 prints, unlimited)
  - Add-ons: wireless sparklers, fog machine, premium backdrops, backdrop
    enclosure, digital guestbook, B&W glam filter, red carpet + stanchions,
    4×6 print upgrade
- **Event types served**: weddings, corporate events, birthdays, proms,
  school events, brand activations, anniversaries, holiday parties,
  charity galas, mitzvahs
- **Booth software**: LumaBooth on iPad/iPhone; galleries hosted via fotoshare.co
- **Contact**: eaphotobooths@gmail.com, (647) 979-1231
- **Social**: @eventsphere.to (GTA), @eventsphere.ott (Ottawa)
- **Current GBP**: claimed, 4 reviews as of project start — needs growth

## Pricing (single source of truth — update here, not in copy)

> **NOTE**: These prices need owner confirmation. The current site has
> conflicting prices ($375–$700 in Services.jsx vs "TBD" in Packages.jsx).
> Until confirmed, every package page should display "from $X" or
> "Request a quote" — never "TBD" (signals abandonment).

**Tentative starting points (to confirm)**:
- Instant Print Photobooth: Silver $375 (2h), Gold $500 (3h), Platinum $650 (4h)
- 360 Video Booth: Silver $400 (2h), Gold $550 (3h), Platinum $700 (4h)
- Ultimate Combo (both booths): owner to provide
- Travel fee outside GTA core: owner to provide formula
- Deposit: owner to provide (suggest $100 non-refundable to hold date)

When any price changes, update this file first, then run a search-and-replace
across `src/content/`.

## Brand

- **Primary**: `#ed70c0` (pink) — CTAs, accents, highlights
- **Hover**: `#db61b2` (darker pink) — button hovers
- **Secondary**: `#4c1d95` (deep purple) — footer, dark sections
- **Background tint**: `#faf5ff` (purple-50) — soft section backgrounds
- **Text**: zinc-900 on light, zinc-100 on dark
- **Font**: system stack until brand font is licensed; if we add one, use
  `font-display: swap` and preload to prevent FOIT/CLS

Tailwind config exposes:
```ts
colors: {
  brand: {
    DEFAULT: '#ed70c0',
    hover: '#db61b2',
    deep: '#4c1d95',
    tint: '#faf5ff',
  }
}
```

Use `bg-brand`, `text-brand`, `hover:bg-brand-hover`. Never hardcode `#ed70c0`
in component classes — that breaks the design system.

## Tech stack (do not change without explicit approval)

- **Astro 5** (pinned via package.json)
- **TypeScript** strict mode
- **Tailwind v4**
- **MDX content collections** for all page content
- **Astro's built-in `<Image>` component** (sharp under the hood) for all
  images — never raw `<img>`
- **Cloudflare Stream or Mux** for video (NOT self-hosted MP4)
- **Formspree** for form submissions (`FORMSPREE_URL` env var)
- **Plausible** for analytics (no cookie banner needed)
- **Vercel** for hosting (preview per PR, prod on main)

## Build, test, deploy commands

- `pnpm dev` — local dev server (http://localhost:4321)
- `pnpm build` — production build (must pass before any commit)
- `pnpm preview` — preview built site locally
- `pnpm astro check` — TypeScript + Astro checking
- `pnpm lint` — ESLint + Prettier
- `pnpm test` — Playwright E2E (when tests exist)
- `pnpm lh` — local Lighthouse against http://localhost:4321
- `/ship` — full pre-deploy gauntlet (slash command)
- `/audit` — full site audit (slash command)

## Non-negotiable rules (these are enforced; don't try to work around them)

1. **Static rendering only.** Every page must render its content in raw HTML.
   No client-rendered text content. Test: `curl -s <url> | grep '<h1'` must
   return the H1.
2. **Every page has unique `<title>`, `<meta description>`, `<link rel="canonical">`,
   OG tags, Twitter card, and at least one JSON-LD block** (LocalBusiness on
   home, Service on booth pages, FAQPage where there's an FAQ).
3. **Performance budget**: mobile LCP < 2.0s, INP < 200ms, CLS < 0.05,
   Lighthouse SEO = 100 always.
4. **All images** go through `<Image>` from `astro:assets`. AVIF + WebP with
   JPEG fallback. Sized at the breakpoint they'll render at, not full size.
5. **All copy must be human-written or human-edited**. No "elevate your event"
   AI slop. Use specific, concrete language. Mention real venues, real cities,
   real numbers.
6. **City pages must be substantively unique** (use `city-page-template` skill —
   it enforces this).
7. **No tracking scripts in `<head>`**. Defer or async only. Plausible is the
   only first-party analytics — do not add GA4 unless explicitly requested.

## Style conventions

- **Branch names**: `feat/...`, `fix/...`, `content/...`, `seo/...`, `chore/...`
- **Commits**: conventional commits (`feat: add ottawa city page`)
- **Never push directly to main.** PR + preview deploy + `/ship` pass first.
- **Filenames**: kebab-case for content (`360-video-booth.mdx`), PascalCase for
  components (`InquiryForm.astro`)
- **Imports**: use the `@/` alias for `src/` (configured in tsconfig)

## Information architecture (the canonical site map)

```
/                                       # home
/booths/360-video-booth                  # service page
/booths/instant-print-booth              # service page
/weddings                                # event-type page
/corporate-events                        # event-type page
/birthdays                               # event-type page
/proms-and-school-events                 # event-type page
/photo-booth-rental-toronto              # location page
/photo-booth-rental-mississauga          # location page
/photo-booth-rental-vaughan              # location page
/photo-booth-rental-markham              # location page
/photo-booth-rental-ottawa               # location page (separate market)
/packages                                # pricing — single source of truth
/gallery                                 # fotoshare-embedded galleries
/about                                   # owner story, credentials
/faq                                     # mega-FAQ with FAQPage schema
/contact                                 # phone, email, map, form
/terms                                   # legal
/privacy                                 # legal
/thanks                                  # post-submit confirmation
/blog/*                                  # future content marketing
```

When adding a new page, first ask: which template (service, event-type, city)
fits? Use that skill. If none fits, the page is probably one-off and needs
hand-crafting — flag this and confirm before building.

## What lives where

- `src/content/booths/*.mdx` — booth service pages
- `src/content/events/*.mdx` — event-type pages
- `src/content/areas/*.mdx` — city/location pages
- `src/content/legal/*.mdx` — terms, privacy
- `src/components/` — reusable Astro components
- `src/components/seo/` — Layout, JsonLd, MetaTags
- `src/lib/schema/` — typed builders for LocalBusiness, Service, FAQPage, etc.
- `src/lib/copy/` — shared copy snippets (CTAs, value props) so they stay consistent
- `public/img/` — static images (favicon, OG defaults); page-specific images
  live in `src/assets/` so Astro can optimize them
- `public/robots.txt`, `public/sitemap-index.xml` — generated by the build

## Things to never do

- Add client-side rendering for SEO-critical content
- Use third-party fonts that block render (always `font-display: swap`)
- Add tracking scripts in `<head>` synchronously
- Change brand voice in copy without showing me first
- Add cities/areas to copy that we don't actually service (legal + GBP risk)
- Reproduce competitor copy or use any AI-generated stock-image-feel content
- Use the word "elevate" in any copy. Or "unleash". Or "unlock the magic of".
  Read it back to yourself — does it sound like a human wrote it?

## Things to always do

- Before adding a new page, check the IA above
- Before publishing, run the seo-page-checklist skill
- After publishing, run the schema-validator subagent
- After any content change, run `pnpm build` to catch type errors
- When pricing changes, update this file FIRST, then content
- When a new client review comes in, update home page testimonials within 24h
- When you finish a feature, write a short note about anything tricky you
  learned into this file under the "Lessons learned" section below

## Lessons learned

(This section grows over time. Add notes here when you discover something
worth remembering — gotchas, decisions, things that didn't work.)

- 2026-05-11: Project kickoff. Migrating from React/Vite SPA to Astro for
  the static-HTML SEO win. Source site reviewed — see docs/AUDIT.md.
