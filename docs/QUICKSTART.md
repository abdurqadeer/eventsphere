# Quickstart: First Prompts for Claude Code

Once you've got the harness in place and run `claude` in the repo, paste these
prompts in order. The harness handles the details — these prompts can stay short.

## Prompt 1 — Foundation (Day 1)

```
Read CLAUDE.md, docs/AUDIT.md, and docs/ROADMAP.md. Then execute Day 1 of the
roadmap:

1. Scaffold an Astro 5 project with TypeScript strict, Tailwind v4, MDX, and
   sitemap integration. Pin versions.
2. Configure Tailwind with my brand colors from CLAUDE.md.
3. Create the base Layout component with proper <head> slots for per-page
   title, meta description, canonical, OG, Twitter, and JSON-LD.
4. Create reusable Header, Footer, CTA Button, and InquiryForm components
   matching the brand styles from CLAUDE.md.
5. Wire the InquiryForm to Formspree using FORMSPREE_URL env var.
6. Create a placeholder home page using the Layout, with real title/meta.
7. Initialize git, commit, and push to a new GitHub repo called "eventsphere".
8. Set up a Vercel project connected to the repo with preview deploys on PRs.

After each step, briefly confirm what you did. After step 8, give me the
preview URL and run the lighthouse-runner subagent against it. We should
see SEO 100 even for a placeholder page.
```

## Prompt 2 — Booth pages with full SEO (Day 2)

```
Execute Day 2 of the roadmap. Build /booths/360-video-booth and
/booths/instant-print-booth as MDX content pages.

For each page:
- Invoke the service-page-template skill for structure
- Invoke the meta-tag-writer skill for title and description
- Invoke the localbusiness-schema and faq-schema skills for JSON-LD
- Invoke the seo-page-checklist skill before considering the page done

Content guidance:
- 360 video booth: emphasize the social-media share factor, the slow-mo capture,
  the unique experience for guests. Target keywords include "360 video booth
  rental Toronto", "360 photobooth GTA".
- Instant print booth: emphasize the take-home keepsake, the customizable
  template with logo for corporate, the unlimited prints. Target keywords
  include "instant print photobooth Toronto", "photo strip rental GTA".

For pricing, use my packages from CLAUDE.md. If pricing isn't in CLAUDE.md
yet, ask me before publishing.

Also update the home page to be the real home page, not a placeholder. Use
the same skills.

When all three pages are done, run /ship.
```

## Prompt 3 — Event types and location pages (Day 3)

```
Execute Day 3 of the roadmap. Build:

Event-type pages (use event-type-page-template skill):
- /weddings
- /corporate-events
- /birthdays
- /proms-and-school-events

Location pages (use city-page-template skill — it enforces uniqueness):
- /photo-booth-rental-toronto
- /photo-booth-rental-mississauga
- /photo-booth-rental-vaughan
- /photo-booth-rental-markham
- /photo-booth-rental-ottawa

For location pages, each one MUST be substantially unique — different opening
paragraph mentioning city-specific venues, different testimonial slot, different
"venues we've worked at" list. If you don't have content for any of these,
ask me — don't generate generic filler.

After each page, run the seo-page-checklist skill. After all pages are done,
run /ship and then submit the updated sitemap to Google Search Console (use
the GitHub MCP to add a GitHub Action for automatic GSC sitemap submission
on every prod deploy).
```

## Future prompts (less templated)

After Day 3 you'll be in the flow and the prompts get more conversational.
Examples:

> Build the FAQ mega-page. Pull every FAQ block from every existing page,
> deduplicate, organize by category, add FAQPage schema covering all of them.

> Update the gallery page to embed our top 6 fotoshare event galleries. Use
> the fotoshare-gallery-embed skill. Add lazy loading and a fallback poster
> for each.

> Run the competitor-watcher subagent on these 5 Toronto photo booth
> companies: [URLs]. Output a brief, not raw HTML.

> A client just sent a 5-star review on Google. Add their first name + event
> type + venue + month to the home page testimonials. Then write a thank-you
> reply for the GBP review.

> It's Tuesday. Run gbp-post-writer for this week's post. Subject: 360 booth
> at Markham wedding last weekend. Tone: enthusiastic but not pushy.

## Tips for fast iteration

- Use `/ship` before any merge — it chains lint, build, Lighthouse, schema,
  a11y in one command
- Use `/audit` weekly to spot regressions
- Use `/new-city-page <city>` when expanding service area — scaffolds the
  page with all schema and the uniqueness constraints already in place
- When you fix a recurring issue, write it as a rule in CLAUDE.md so Claude
  catches it next time without being told
- Use subagents (lighthouse-runner, accessibility-checker) for noisy work —
  they keep their own context clean and only report the actionable bits
