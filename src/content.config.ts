import { defineCollection, z } from "astro:content";
import { glob } from "astro/loaders";

const booths = defineCollection({
  loader: glob({ pattern: "**/*.{md,mdx}", base: "src/content/booths" }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    order: z.number().optional(),
  }),
});

const events = defineCollection({
  loader: glob({ pattern: "**/*.{md,mdx}", base: "src/content/events" }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
  }),
});

const areas = defineCollection({
  loader: glob({ pattern: "**/*.{md,mdx}", base: "src/content/areas" }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    city: z.string(),
  }),
});

const legal = defineCollection({
  loader: glob({ pattern: "**/*.{md,mdx}", base: "src/content/legal" }),
  schema: z.object({
    title: z.string(),
    lastUpdated: z.string(),
  }),
});

export const collections = { booths, events, areas, legal };
