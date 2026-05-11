# Agent State — read this at the start of every session

This file tracks volatile project state: where we are in the sprint, what's
deployed, and what the next agent needs to pick up without asking.

Update it when: a day completes, a URL changes, a decision is made that isn't
captured in CLAUDE.md, or a task is left mid-flight.

## Current position

- **Sprint day**: Day 1 complete — ready to start Day 2
- **Last session**: 2026-05-11
- **Next task**: Execute Day 2 (home page + booth pages — see docs/ROADMAP.md)

## Live URLs

| Environment | URL | Notes |
|---|---|---|
| Production (Vercel alias) | https://eventsphere-cyan.vercel.app | Stable alias — always points to latest prod deploy |
| GitHub repo | https://github.com/abdurqadeer/eventsphere | main branch = production |

## Vercel infra IDs (needed by CLI / GitHub Actions)

```
VERCEL_PROJECT_ID=prj_CkwXZUEcnw9nxL3otdTw8Ns2f0HW
VERCEL_ORG_ID=PxykswDI0pSpcrWSRPY2z7YV
```

These are also stored as GitHub Actions secrets so CI deploys work without
manual config.

## Domain / DNS status

- **eventspherephotobooths.com** — still pointing at the OLD React/Vite site.
  Do NOT cut over until Day 5.
- When cutting over: update `PROD_DOMAIN` in `astro.config.mjs` AND the
  `Sitemap:` line in `public/robots.txt` to `https://eventspherephotobooths.com`.

## Environment variables

| Var | Where set | Status |
|---|---|---|
| `FORMSPREE_URL` | Vercel project env vars | ⚠ NOT SET — form shows warning banner |
| `VERCEL_TOKEN` | GitHub Actions secret | ✓ set |
| `VERCEL_ORG_ID` | GitHub Actions secret | ✓ set |
| `VERCEL_PROJECT_ID` | GitHub Actions secret | ✓ set |

To fix the Formspree warning: Vercel dashboard → Project → Settings →
Environment Variables → add `FORMSPREE_URL` = your Formspree endpoint.

## What's built (Day 1 deliverables)

- [x] `src/layouts/Layout.astro` — base layout with all head slots
- [x] `src/components/Header.astro` — sticky nav, mobile menu
- [x] `src/components/Footer.astro` — deep purple, all nav links
- [x] `src/components/CTAButton.astro` — primary/secondary/outline variants
- [x] `src/components/InquiryForm.astro` — Formspree, honeypot, event type select
- [x] `src/pages/index.astro` — placeholder home, LocalBusiness JSON-LD
- [x] `src/pages/thanks.astro` — post-form confirmation
- [x] `src/content.config.ts` — typed collections for booths/events/areas/legal
- [x] `src/styles/global.css` — Tailwind v4 @theme with brand tokens
- [x] `public/robots.txt` — allows all, Sitemap line set
- [x] `public/img/og-default.jpg` — 1200×630 brand OG image
- [x] `public/favicon.svg` — pink E mark
- [x] `.github/workflows/preview.yml` — PR preview deploy + comment
- [x] `.github/workflows/production.yml` — push to main → prod deploy

## What's NOT built yet (Day 2+)

- [ ] Real home page (hero with poster image, value props, testimonials, FAQ)
- [ ] `/booths/360-video-booth` MDX page + Service schema
- [ ] `/booths/instant-print-booth` MDX page + Service schema
- [ ] All event-type pages (weddings, corporate, birthdays, proms)
- [ ] All location pages (Toronto, Mississauga, Vaughan, Markham, Ottawa)
- [ ] Gallery, packages, about, FAQ, contact, terms, privacy pages
- [ ] Plausible analytics snippet
- [ ] Real images (hero, booth photos, team photo)

## Pricing status

Prices in CLAUDE.md are **tentative** — owner has not confirmed. All package
pages must show "from $X" language until owner confirms. Never show "TBD".
