---
name: gbp-post-writer
description: Writes Google Business Profile posts in the format Google rewards (consistent weekly cadence, 150-300 chars, soft CTA). GBP posts are a freshness signal — a missed week is a small loss, missing months hurts ranking.
---

Write a Google Business Profile post.

## Format rules

- **Length**: 150-300 characters (the visible preview is the first ~80 chars,
  so front-load the value)
- **Tone**: enthusiastic but not pushy. No exclamation marks in the first
  sentence. No emoji clusters.
- **Structure**: hook (what happened) + 1 specific detail + soft CTA
- **CTA wording**: GBP allows specific CTA buttons (Book, Order, Learn more,
  Sign up, Call, Get offer). Pick one and don't repeat the CTA text in the body.
- **No links in body** — the CTA button handles linking. Body text with URLs
  in it gets flagged.
- **No marketing-flag words**: "best", "guaranteed", "#1", "exclusive" — these
  trigger GBP's spam filter and the post may not show.

## Templates by post type

### Event recap (most common — use weekly)

```
[Specific event detail] at [venue type] this [day/weekend]. [What we ran].
[Small observation that shows personality]. [Soft CTA hint].

CTA button: Book
```

Example:
> Set up our 360 booth at a wedding at The Berkeley Church on Saturday.
> The slow-mo videos with sparklers got 200+ shares on the bride's IG
> by Sunday. Spring wedding season is filling up fast.
>
> CTA button: Book

### New service / capability

```
[New capability]. [Why it matters for the kind of events you run]. [How
to get it].

CTA button: Learn more
```

### Seasonal / time-bound

```
[Specific window]. [What this means for booking]. [Soft urgency without
being pushy].

CTA button: Book
```

### Behind the scenes

```
[Specific thing you did today/this week]. [Why we do it that way].
[Connection to client value].

CTA button: Call now
```

## Anti-patterns

- Generic motivational ("Capture every moment of your special day!")
- Hard sell ("Book now and save 20%!" — also against GBP terms for
  service-area businesses)
- Stock quotes ("Memories last forever")
- No specific detail (a post that could be any photo booth company's post)
- Posting twice in one day (Google deprioritizes the older one)
- Adding the same post to GBP that you posted on Instagram (duplicate
  content, lower reach)

## Image rules

- Always include a photo (image-less posts get ~5× less impression share)
- 1200×900 or larger, JPG
- Real event photo > stock photo every time
- If using an event photo: confirm you have client permission
- Don't reuse the same image across two consecutive posts

## Cadence

- 1 post per week minimum. Tuesday or Wednesday performs best.
- Don't skip more than 2 consecutive weeks — the freshness signal decays
- Special event happening (e.g., wedding show booth)? Post a day before
  AND a day after for double freshness

## Output

When invoked, ask for:
1. What happened (event type, venue if shareable, week)
2. Best photo from the event
3. Which CTA fits

Then output the post text with character count, the recommended CTA button,
and the image path. If you don't have the input, suggest 3 different angles
based on what we know is happening this week (read CLAUDE.md and any recent
content in src/content/blog/).
