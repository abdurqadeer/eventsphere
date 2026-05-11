---
name: faq-schema
description: Generates both a rendered FAQ component AND matching FAQPage JSON-LD from a list of Q&A pairs. Use on any page with an FAQ section. FAQPage schema is the highest-leverage structured data for AI Overviews — Google sources from it heavily.
---

Generate an FAQ section with matching JSON-LD from a list of Q&A pairs.

## Input format

You'll receive Q&A pairs as either:
- A markdown list ("**Q:** ...\n**A:** ...")
- Frontmatter array
- Inline in MDX

## Output

Produce two things:

### 1. The Astro component invocation

```astro
---
import Faq from '@/components/Faq.astro';
import { faqSchema } from '@/lib/schema/faqPage';

const items = [
  {
    q: "How much space do you need for the 360 booth?",
    a: "We need a 10×10 ft area with 8 ft of ceiling clearance. The booth itself is 6 ft wide, but we want room for guests to enter and exit safely."
  },
  // ...
];
---

<Faq items={items} />
<script type="application/ld+json" set:html={JSON.stringify(faqSchema(items))} />
```

### 2. The schema builder (write once, reuse everywhere)

```ts
// src/lib/schema/faqPage.ts
import type { WithContext, FAQPage } from 'schema-dts';

export function faqSchema(items: { q: string; a: string }[]): WithContext<FAQPage> {
  return {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: items.map(({ q, a }) => ({
      '@type': 'Question',
      name: q,
      acceptedAnswer: {
        '@type': 'Answer',
        text: a,
      },
    })),
  };
}
```

## Rules for the Q&A content

1. Questions should be **how a real person asks**, not how a marketer would
   phrase it. "How much is a photo booth?" not "What are your pricing options?"
2. Answers should be **1-3 sentences**, direct, with specific numbers/facts
   where applicable.
3. **First answer answers the question.** Don't bury the lede with brand fluff.
4. **No marketing puffery in answers.** "We use professional equipment" is
   filler. "We use Canon DSLR cameras with studio lighting" is information.
5. Answers should not contradict other pages on the site (pricing, policies).
   Pull from CLAUDE.md as the source of truth.
6. If an answer requires HTML formatting (lists, bold), strip it for the
   `text` field of the JSON-LD — that field expects plain text.
7. Don't include questions with "no comment" answers ("Do you do X?" "Maybe
   email us"). If you can't answer it concretely, leave it off.

## Common FAQ themes by page type

**Booth pages** (5-8 questions):
- Space, power, internet requirements
- What's included vs. add-on
- Customization options
- How long sessions take
- What guests take home

**Event-type pages** (5-8 questions):
- Booking lead time for this event type
- Event-specific concerns (timeline for weddings, branding for corporate)
- Travel/destination
- Overtime rates
- Setup logistics for typical venues

**Main /faq page** (15-25 questions):
- Aggregate of the best from all pages, organized by category
- This is the highest-traffic FAQ page — make it comprehensive

## Validation

After generating, run the `schema-validator` subagent. Common errors to
catch yourself:
- Question text in `text` instead of `name`
- Answer text containing escaped HTML
- Missing `@type: Answer` wrapper around the answer object
