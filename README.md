# Eventsphere Photobooths — Claude Code Starter Pack

This is the harness for rebuilding `eventspherephotobooths.com` with Claude Code.
It contains the project memory (`CLAUDE.md`), MCP server config, subagents, skills,
hooks, and slash commands — everything Claude Code needs to do the rebuild without
constant hand-holding.

## What's in here

```
.
├── CLAUDE.md                   # Project memory — Claude reads this every session
├── .claude/
│   ├── settings.json           # Team-wide permission rules
│   ├── mcp.json                # MCP server config (Playwright, GitHub, Context7)
│   ├── agents/                 # Subagents: isolated workers with their own context
│   ├── skills/                 # Skills: in-context playbooks Claude can invoke
│   ├── hooks/                  # Lifecycle scripts (pre-deploy, post-edit, etc.)
│   └── commands/               # Slash commands you can run with /name
└── docs/
    ├── AUDIT.md                # Findings from the current React/Vite site
    ├── ROADMAP.md              # 7-day execution sprint
    └── QUICKSTART.md           # First 3 prompts to run in Claude Code
```

## Setup (one time, ~15 minutes)

### 1. Install Claude Code
```bash
npm install -g @anthropic-ai/claude-code
```

### 2. Create the project repo
```bash
mkdir eventsphere && cd eventsphere
git init
```

### 3. Copy this starter pack in
Copy the contents of this folder into the repo root. Commit it:
```bash
git add . && git commit -m "chore: add Claude Code harness"
```

### 4. Set up your secrets
Create `.claude/settings.local.json` (already gitignored) with:
```json
{
  "env": {
    "GITHUB_PAT": "ghp_...",
    "VERCEL_TOKEN": "...",
    "FORMSPREE_FORM_ID": "..."
  }
}
```

### 5. Install the MCP servers
The first time you run Claude Code in this repo, it will offer to install
the servers listed in `.claude/mcp.json`. Approve them. They are:

- **Playwright MCP** — for headless browser, Lighthouse, screenshots
- **GitHub MCP** — for PRs, issues, Actions
- **Context7 MCP** — for live, version-pinned docs (Astro, Tailwind)

### 6. Make the hooks executable
```bash
chmod +x .claude/hooks/*.sh
```

### 7. Start Claude Code
```bash
claude
```

Then open `docs/QUICKSTART.md` and paste the first prompt.

## Decision log (why this stack)

- **Astro 5 + TypeScript + Tailwind v4** — content site, not an app. Astro
  ships ~0 KB JS by default, which fixes the SPA-crawler problem your current
  React/Vite site has.
- **Vercel** — preview deploys per PR, zero-config Astro support.
- **MDX content collections** — type-safe page content, no CMS needed at this scale.
- **fotoshare.co subdomain** — gallery hosting stays on LumaBooth's platform, we
  embed event galleries by iframe + link directly to event microsites.
- **Formspree** (existing) for now → Resend later when you want branded emails.

## Decision log (why this harness)

The four-layer Claude Code stack — CLAUDE.md, skills, subagents, hooks —
each does a different job:

- **CLAUDE.md** is rules and facts that should be true every session
- **Skills** are repeatable playbooks Claude invokes when relevant
- **Subagents** are noisy workers (Lighthouse, schema validation) whose output
  shouldn't pollute the main context
- **Hooks** are deterministic guardrails the model cannot reason around

Don't move logic between layers without thinking about which one fits.

## What to do next

1. Read `docs/AUDIT.md` to see the concrete findings from your current code
2. Read `docs/ROADMAP.md` for the 7-day execution plan
3. Open `docs/QUICKSTART.md` and run the first prompt in Claude Code
