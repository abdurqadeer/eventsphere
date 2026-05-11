import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";
import tailwindcss from "@tailwindcss/vite";

// Use the stable Vercel alias until DNS is cut over on Day 5.
// After DNS cutover: change PROD_DOMAIN to eventspherephotobooths.com
const PROD_DOMAIN = "https://eventsphere-cyan.vercel.app";
const site =
  process.env.VERCEL_ENV === "preview" && process.env.VERCEL_URL
    ? `https://${process.env.VERCEL_URL}`
    : PROD_DOMAIN;

export default defineConfig({
  site,
  integrations: [
    mdx(),
    sitemap(),
  ],
  vite: {
    plugins: [tailwindcss()],
  },
});
