# 7-Day Sprint Roadmap

Speed-prioritized rebuild plan. Each day is one focused Claude Code session.
Skip nothing — the order matters because later work depends on earlier setup.

## Day 1 — Foundation (~3 hours)

**Goal:** new Astro repo deployed to a preview URL with the design system live.

- Scaffold Astro project: `pnpm create astro@latest`. Pick: empty, TypeScript strict, install deps, init git
- Add Tailwind v4: `pnpm astro add tailwind`
- Add MDX support: `pnpm astro add mdx`
- Add sitemap integration: `pnpm astro add sitemap`
- Add `@astrojs/image` or use built-in `<Image>` from `astro:assets`
- Configure Tailwind with brand colors: `--brand-pink: #ed70c0`, `--brand-purple: #4c1d95`
- Create base Layout component with `<head>` slots for per-page title/meta/JSON-LD
- Create Header, Footer, CTA Button, Inquiry Form components
- Wire Formspree with `VITE_FORMSPREE_URL` → `FORMSPREE_URL` env
- Push to GitHub
- Connect to Vercel; preview deploy on every PR, prod on main
- Set up Plausible (privacy-friendly, no cookie banner needed) or GA4

**Done when:** Vercel preview URL renders a styled placeholder home page with working inquiry form, real `<title>`, and Lighthouse SEO score = 100.

## Day 2 — Home + booth pages (~4 hours)

**Goal:** all 3 primary commercial pages live with real content.

- `/` — hero (with poster image, video lazy-loaded), 3 value props, social proof strip (4 logos of past venues if you have permission), booth previews, recent events grid (fotoshare-embedded), inquiry CTA, FAQ
- `/booths/360-video-booth` — hero, what's included, sample reels (lazy-loaded), pricing table, FAQ, schema, CTA
- `/booths/instant-print-booth` — same structure
- Real copy with Toronto, Ottawa, GTA, "wedding photo booth", "corporate event" naturally placed
- Every page: LocalBusiness schema (home), Service schema (booth pages), FAQPage schema (where FAQ exists)
- Every image: optimized, alt text via `alt-text-generator` skill
- Every page passes `seo-page-checklist` skill validation

**Done when:** all three pages have Lighthouse 100 for SEO + A11y, mobile LCP < 2.0s, schema validates.

## Day 3 — Event types + service areas (~4 hours)

**Goal:** capture commercial-intent search traffic.

Event type pages (each gets its own URL with unique content):
- `/weddings` — wedding-specific copy, venue list, packages tuned for weddings, wedding FAQ
- `/corporate-events` — branding/data-capture angle, corporate package, corporate FAQ
- `/birthdays` — birthday-specific
- `/proms-and-school-events` — school market angle

Location pages (only if actively servicing each):
- `/photo-booth-rental-toronto` — Toronto-specific, downtown venues, GTA travel info
- `/photo-booth-rental-mississauga`
- `/photo-booth-rental-vaughan`
- `/photo-booth-rental-markham`
- `/photo-booth-rental-ottawa` — Ottawa-specific page (driven by your IG presence)

Each location page MUST be unique (use `city-page-template` skill which enforces this):
- Unique opening paragraph mentioning city-specific landmarks/venues
- Different testimonial slot (real client from that city ideally)
- Different "venues we've worked at" list
- Travel-fee section if applicable

**Done when:** every page is in `sitemap.xml`, no two location pages share more than 30% of text.

## Day 4 — Gallery, packages, about, FAQ, contact (~4 hours)

**Goal:** secondary pages that close the loop on trust and conversion.

- `/gallery` — embed best fotoshare event galleries via iframe; one section per event type
- `/packages` — single source of truth for pricing; real prices, not "TBD"; clear what's included/excluded; FAQ about deposits, cancellation, travel fees
- `/about` — owner story, credentials (insurance carrier, PAT testing if applicable), equipment list, photo of you/the team
- `/faq` — combine FAQs from all pages into one mega-FAQ with full FAQPage schema; this page punches above its weight for AI Overview eligibility
- `/contact` — phone (click-to-call), email (real `mailto`), service-area map, embedded inquiry form, response-time expectation
- `/terms` and `/privacy` — required for trust, also required for GBP compliance

**Done when:** every page in the IA is live, sitemap submitted to GSC + Bing.

## Day 5 — Off-site + technical SEO (~3 hours)

**Goal:** Google can find and trust the site.

- Cutover DNS — point eventspherephotobooths.com to Vercel
- Submit sitemap to Google Search Console + Bing Webmaster Tools
- Optimize Google Business Profile:
  - Primary category: Photo booth
  - Secondary: Wedding service, Party equipment rental service, Event planner
  - All service area cities added
  - 30+ recent photos uploaded
  - Services list with prices
  - First weekly Google Post published
- Claim Bing Places, Apple Business Connect
- Submit listings: WeddingWire, The Knot Canada, EventSource.ca, Yelp, 411.ca, Yellowpages.ca
- Set up the review-request flow: write the SMS + email template, build the past-client list, send first batch
- Run `audit` slash command — should now show green across the board

**Done when:** sitemap is indexed, GBP shows 100% complete, first review-request batch sent.

## Day 6 — Conversion infrastructure (~3 hours)

**Goal:** when someone wants to book, nothing gets in the way.

- Wire inquiry form submissions to:
  1. Your email (already via Formspree)
  2. A Google Sheet (Formspree integration)
  3. Optional: Pipedrive or HubSpot Free CRM
- Set up auto-responder email confirming receipt, including 24-hour SLA and a link to FAQ
- Add a clear booking calendar (Calendly or Cal.com) for "free consultation" calls — captures leads who aren't ready to commit
- Add tracking events: form view, form submit, phone tap, email tap, gallery scroll depth
- Build a thank-you page (`/thanks`) with conversion tracking + "while you wait" content (link to FAQ, IG, gallery)

**Done when:** end-to-end inquiry flow tested from cold visit to email arriving in your inbox.

## Day 7 — Launch polish + monitoring (~3 hours)

**Goal:** confident production launch.

- Run full audit: `/ship` slash command runs lint, build, Lighthouse, schema validation, a11y check
- Fix any remaining warnings
- Set up Sentry for error monitoring (free tier)
- Set up uptime monitoring (UptimeRobot, free)
- Set up weekly competitor-watcher subagent (cron via GitHub Actions)
- Set up Search Console email alerts for crawl errors
- Write the first blog post: "How much does a photo booth rental cost in Toronto?" — this single post captures a high-intent informational search
- Announce on Instagram (@eventsphere.to and @eventsphere.ott)
- Email past clients announcing the new site + asking for a review
- Open `docs/MONTH-2.md` (we'll write it after launch) — covers blog cadence, content expansion, paid search trial

**Done when:** old site is replaced, GSC is reporting impressions, first organic visitor arrives.

## After day 7 (ongoing)

Weekly (15 min):
- One Google Business Profile post
- Reply to all reviews within 24 hours
- Check GSC for new query opportunities (queries you're impressing for but ranking 8-20 — easy wins)

Monthly (2-3 hours):
- One blog post (use `content-writer` subagent + your knowledge of the events you ran that month)
- Add 3-5 new event photos to gallery
- Run `competitor-watcher` subagent on top 5 local competitors
- Send review-request batch to clients from the past month

Quarterly:
- Full re-audit (`/audit` slash command)
- Add one new service area page if you've started working a new area
- Consider Google Ads if organic isn't filling enough of the calendar

## How to use the harness during the sprint

Each day, start by reading `docs/QUICKSTART.md`. The prompts there reference
the skills, subagents, and commands defined in this repo. You shouldn't need
to write detailed instructions — the harness already knows what "build a
booth page" or "run the audit" means.

When you need something the harness doesn't know about, write it into the
appropriate layer:
- A new persistent fact → `CLAUDE.md`
- A new repeatable workflow → new file in `.claude/skills/`
- A new noisy worker → new file in `.claude/agents/`
- A new guardrail → new file in `.claude/hooks/`
