---
name: localbusiness-schema
description: Generates valid LocalBusiness JSON-LD for Eventsphere. Use when adding schema to the home page, contact page, or any page that establishes the business identity. Pulls business facts from CLAUDE.md.
---

Generate a LocalBusiness JSON-LD block for Eventsphere Photobooths.

## Process

1. Read CLAUDE.md to get current values for name, contact, service areas,
   prices, social profiles.
2. Generate the JSON-LD using the template below.
3. Output as a TypeScript-ready const so it can be imported by the Layout
   component.

## Template

```ts
// src/lib/schema/localBusiness.ts
import type { WithContext, LocalBusiness } from 'schema-dts';

export const localBusiness: WithContext<LocalBusiness> = {
  '@context': 'https://schema.org',
  '@type': 'LocalBusiness',
  '@id': 'https://www.eventspherephotobooths.com/#business',
  name: 'Eventsphere Photobooths',
  alternateName: 'Eventsphere',
  description: 'Photo booth rental serving the Greater Toronto Area and Ottawa. 360 video booth and instant print photobooth for weddings, corporate events, and parties.',
  url: 'https://www.eventspherephotobooths.com',
  telephone: '+1-647-979-1231',
  email: 'eaphotobooths@gmail.com',
  image: 'https://www.eventspherephotobooths.com/og/default.jpg',
  priceRange: '$$',
  address: {
    '@type': 'PostalAddress',
    addressLocality: 'Toronto',
    addressRegion: 'ON',
    addressCountry: 'CA',
    // streetAddress intentionally omitted — service-area business
  },
  areaServed: [
    { '@type': 'City', name: 'Toronto' },
    { '@type': 'City', name: 'Mississauga' },
    { '@type': 'City', name: 'Vaughan' },
    { '@type': 'City', name: 'Markham' },
    { '@type': 'City', name: 'Brampton' },
    { '@type': 'City', name: 'Richmond Hill' },
    { '@type': 'City', name: 'Oakville' },
    { '@type': 'City', name: 'Burlington' },
    { '@type': 'City', name: 'Ottawa' },
    { '@type': 'AdministrativeArea', name: 'Greater Toronto Area' },
  ],
  sameAs: [
    'https://www.instagram.com/eventsphere.to/',
    'https://www.instagram.com/eventsphere.ott/',
    // Add GBP URL once available
    // Add Facebook URL once available
  ],
  hasOfferCatalog: {
    '@type': 'OfferCatalog',
    name: 'Photo Booth Rental Packages',
    itemListElement: [
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: 'Instant Print Photobooth Rental',
          serviceType: 'Photo booth rental',
        },
        priceCurrency: 'CAD',
        price: '375',
        priceSpecification: {
          '@type': 'PriceSpecification',
          price: '375',
          priceCurrency: 'CAD',
          valueAddedTaxIncluded: false,
        },
      },
      {
        '@type': 'Offer',
        itemOffered: {
          '@type': 'Service',
          name: '360 Video Booth Rental',
          serviceType: '360 photo booth rental',
        },
        priceCurrency: 'CAD',
        price: '400',
        priceSpecification: {
          '@type': 'PriceSpecification',
          price: '400',
          priceCurrency: 'CAD',
          valueAddedTaxIncluded: false,
        },
      },
    ],
  },
  // Add aggregateRating once we have 5+ reviews on GBP
  // aggregateRating: {
  //   '@type': 'AggregateRating',
  //   ratingValue: '5.0',
  //   reviewCount: '12',
  // },
};
```

## Rules

- Use the exact business name from CLAUDE.md, including capitalization
- `telephone` must be in E.164 format (`+1-647-979-1231`)
- `image` must be an absolute URL
- `areaServed` should match the actual service area from CLAUDE.md
- Don't fabricate `aggregateRating` — only include once we genuinely have
  5+ Google reviews
- `priceRange` "$$" is appropriate for $300-$800 services in Toronto
- Update prices to match CLAUDE.md current values
- After generating, validate with the `schema-validator` subagent
