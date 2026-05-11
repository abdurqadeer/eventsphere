---
name: fotoshare-gallery-embed
description: Embeds LumaBooth event galleries from fotoshare.co into Eventsphere pages. Use when adding event galleries to the home page, gallery page, event-type pages, or city pages. Handles iframe scaffolding, lazy loading, fallback poster, and link-out for users who want to see the full gallery on fotoshare's microsite.
---

Embed a fotoshare.co event gallery on an Eventsphere page.

## Background

Eventsphere runs events on LumaBooth. Each event's photos and videos are
automatically hosted on fotoshare.co (LumaBooth's gallery platform). Each
event gets its own microsite URL.

The fotoshare Cloud subscription enables:
- A custom subdomain (set up `events.eventspherephotobooths.com` as a CNAME
  to fotoshare and configure in fotoshare dashboard)
- Embeddable iframes per event
- A personalized homepage listing all events

We embed selectively (best events on the gallery page, recent events on the
home page) and link to fotoshare for the full collection.

## DNS setup (one-time, owner action)

In Cloudflare (or wherever DNS is managed):
```
events  CNAME  fotoshare.co
```

Then in fotoshare Cloud dashboard:
- Settings → Custom subdomain → enter `events.eventspherephotobooths.com`
- Wait for verification (usually <5 min)

Once set up, all event gallery URLs become
`events.eventspherephotobooths.com/<event-slug>` instead of
`<random>.fotoshare.co/<event-slug>`.

## Embed component (build once, reuse)

```astro
---
// src/components/FotoshareEmbed.astro
interface Props {
  eventSlug: string;
  title: string;
  posterImage: string;  // local fallback while iframe loads
  height?: number;
}
const { eventSlug, title, posterImage, height = 600 } = Astro.props;
const embedUrl = `https://events.eventspherephotobooths.com/${eventSlug}?embed=1`;
const fullUrl = `https://events.eventspherephotobooths.com/${eventSlug}`;
---

<div class="fotoshare-embed">
  <iframe
    src={embedUrl}
    title={`Photo gallery from ${title}`}
    loading="lazy"
    height={height}
    width="100%"
    frameborder="0"
    allow="fullscreen"
    style={`background-image:url(${posterImage});background-size:cover;`}
  ></iframe>
  <p class="see-all">
    <a href={fullUrl} target="_blank" rel="noopener">
      See the full gallery for {title} →
    </a>
  </p>
</div>
```

## Per-page usage patterns

### Home page (recent events strip)
```astro
<section>
  <h2>Recent events</h2>
  <div class="grid">
    <FotoshareEmbed
      eventSlug="berkeley-church-may-2026"
      title="Wedding at The Berkeley Church"
      posterImage="/img/events/berkeley-poster.jpg"
      height={400}
    />
    <!-- 2-3 more -->
  </div>
</section>
```

### /gallery page (chunked by event type)
```astro
<section>
  <h2>Weddings</h2>
  <FotoshareEmbed eventSlug="..." title="..." posterImage="..." height={500} />
  <FotoshareEmbed eventSlug="..." title="..." posterImage="..." height={500} />

  <h2>Corporate Events</h2>
  <FotoshareEmbed eventSlug="..." title="..." posterImage="..." height={500} />
</section>
```

### Event-type page (filtered to that event type)
- Show 2-3 best events of that type only
- Include event venue + month in the title

### City page (filtered to that city)
- Show only events that happened in that city
- This reinforces the city-page's local relevance signal

## Performance

- Always `loading="lazy"` — iframes are heavy and shouldn't block LCP
- Always provide a `posterImage` — the iframe loads slowly on mobile networks,
  the poster fills the space immediately
- Don't embed more than 3 iframes above the fold on any page
- If a page has many events to show, switch to a static grid of poster images
  that link out to fotoshare on click — much lighter than multiple iframes

## Privacy

Some clients prefer their event gallery be link-protected rather than
public-embeddable. Before adding an event to the site:
1. Check fotoshare event privacy setting (the booking workflow should
   capture client preference)
2. If client opted out, do NOT embed — use a placeholder card with stock
   "private event" imagery
3. If client opted in, embed and link freely

When in doubt, ask the client.

## SEO consideration

The content inside the iframe is on fotoshare's domain, not yours.
That means embedding doesn't directly help your SEO via the iframe content.
But it helps indirectly: it improves engagement metrics (time on page,
behavioral signals) and provides social proof, both of which factor into
ranking.

Wrap each embed with a brief textual caption on the parent page describing
the event ("Wedding at The Berkeley Church, May 2026. 360 video booth ran
during cocktails and dancing.") — that text IS on your domain and counts.
