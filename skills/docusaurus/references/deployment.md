# Deployment

Getting your docs live. Pick the platform that fits your workflow.

---

## Quick Decision

| Platform | Best For | Effort |
|----------|----------|--------|
| **Vercel** | Teams already using Vercel | Lowest |
| **Netlify** | Need redirects, forms, functions | Low |
| **GitHub Pages** | Open source, simple hosting | Low |
| **Cloudflare Pages** | Global performance, free tier | Low |

**My recommendation:** Vercel or Netlify for most projects. GitHub Pages if you want everything in one repo.

---

## Vercel

### Setup

1. Push to GitHub
2. Import at vercel.com
3. Done—it auto-detects Docusaurus

### Config (vercel.json, usually not needed)

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "build"
}
```

Vercel handles this automatically. Only add if you need overrides.

---

## Netlify

### Setup

1. Push to GitHub
2. Connect at app.netlify.com
3. Build command: `npm run build`
4. Publish directory: `build`

### Config (netlify.toml)

```toml
[build]
  command = "npm run build"
  publish = "build"

[[redirects]]
  from = "/old-path"
  to = "/new-path"
  status = 301
```

**Opinion:** Netlify's redirect handling is cleaner than most.

---

## GitHub Pages

### Config

```typescript
// docusaurus.config.ts
const config = {
  url: 'https://username.github.io',
  baseUrl: '/repo-name/',  // or '/' for username.github.io
  organizationName: 'username',
  projectName: 'repo-name',
  trailingSlash: false,
};
```

### GitHub Actions (recommended)

`.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    branches: [main]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
      - run: npm ci
      - run: npm run build
      - uses: actions/upload-pages-artifact@v3
        with:
          path: build

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/deploy-pages@v4
        id: deployment
```

Enable Pages in repo settings → Pages → Source: GitHub Actions.

---

## Cloudflare Pages

### Setup

1. Connect repo at pages.cloudflare.com
2. Framework: None (not auto-detected well)
3. Build command: `npm run build`
4. Output directory: `build`

### Why Cloudflare

- Fastest global CDN
- Generous free tier
- Web analytics included

---

## Pre-Deployment Checklist

Before pushing:

```bash
# 1. Build locally first
npm run build

# 2. Test the build
npm run serve

# 3. Check for broken links (build will fail if onBrokenLinks: 'throw')
# 4. Verify all images load
# 5. Test search works (if Algolia configured)
```

---

## Custom Domain

All platforms support custom domains. General steps:

1. Add domain in platform settings
2. Update DNS:
   - `A` record to platform IP, or
   - `CNAME` to platform URL
3. Wait for SSL certificate (automatic, usually minutes)
4. Update `url` in docusaurus.config.ts

**DNS propagation:** Can take up to 48 hours. Usually much faster.

---

## Environment-Specific Builds

For staging vs production:

```typescript
const isProd = process.env.NODE_ENV === 'production';

const config = {
  url: isProd
    ? 'https://docs.example.com'
    : 'https://staging-docs.example.com',
};
```

Or use platform environment variables.

---

## Common Issues

### Build Fails Locally But Worked Before

```bash
rm -rf node_modules .docusaurus
npm ci
npm run build
```

### Build Works Locally, Fails in CI

- Check Node.js version matches
- Check for case-sensitive filename issues (Linux is case-sensitive, macOS isn't)
- Check for absolute paths that only exist on your machine

### "Page Not Found" After Deploy

- Check `baseUrl` matches your hosting path
- Check `trailingSlash` is consistent
- Clear CDN cache if platform supports it
