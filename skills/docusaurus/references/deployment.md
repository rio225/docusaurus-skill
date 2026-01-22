# Deployment Reference

Complete guide to deploying Docusaurus sites.

## Table of Contents
- [Build Commands](#build-commands)
- [GitHub Pages](#github-pages)
- [Vercel](#vercel)
- [Netlify](#netlify)
- [Cloudflare Pages](#cloudflare-pages)
- [Docker](#docker)
- [Environment Variables](#environment-variables)

---

## Build Commands

### Standard Build
```bash
# Production build
npm run build

# Output in ./build directory
```

### Build with Environment Variables
```bash
# Custom base URL
BASE_URL=/my-project/ npm run build

# Custom URL
URL=https://custom.domain.com npm run build
```

### Serve Locally (Preview Build)
```bash
npm run serve

# Or with specific port
npm run serve -- --port 3001
```

### Clear Cache
```bash
npm run clear
# or
rm -rf .docusaurus node_modules/.cache
```

---

## GitHub Pages

### Configuration

```typescript
// docusaurus.config.ts
const config = {
  url: 'https://username.github.io',
  baseUrl: '/repo-name/',  // or '/' for username.github.io
  organizationName: 'username',
  projectName: 'repo-name',
  deploymentBranch: 'gh-pages',
  trailingSlash: false,
};
```

### Deploy Command
```bash
# Using SSH
USE_SSH=true npm run deploy

# Using HTTPS (needs GIT_USER)
GIT_USER=username npm run deploy
```

### GitHub Actions Workflow

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm

      - name: Install dependencies
        run: npm ci

      - name: Build website
        run: npm run build

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: build

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

---

## Vercel

### Configuration

```typescript
// docusaurus.config.ts
const config = {
  url: 'https://your-project.vercel.app',
  baseUrl: '/',
};
```

### vercel.json (Optional)
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "build",
  "installCommand": "npm install",
  "framework": "docusaurus-2"
}
```

### Deploy Steps

1. Push to GitHub/GitLab/Bitbucket
2. Import project at vercel.com
3. Vercel auto-detects Docusaurus
4. Automatic deploys on push

### Environment Variables in Vercel

Set in Vercel Dashboard → Project → Settings → Environment Variables:
- `NODE_VERSION`: `20`
- Custom variables accessible via `process.env.VAR_NAME`

---

## Netlify

### Configuration

```typescript
// docusaurus.config.ts
const config = {
  url: 'https://your-site.netlify.app',
  baseUrl: '/',
};
```

### netlify.toml
```toml
[build]
  command = "npm run build"
  publish = "build"

[build.environment]
  NODE_VERSION = "20"

# SPA redirects
[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

# Custom headers
[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-Content-Type-Options = "nosniff"
```

### Deploy Steps

1. Push to Git provider
2. Connect repo at app.netlify.com
3. Configure:
   - Build command: `npm run build`
   - Publish directory: `build`
4. Deploy

### Branch Deploys
Netlify auto-creates preview URLs for pull requests.

---

## Cloudflare Pages

### Configuration

```typescript
// docusaurus.config.ts
const config = {
  url: 'https://your-project.pages.dev',
  baseUrl: '/',
};
```

### Deploy Steps

1. Connect GitHub repo at pages.cloudflare.com
2. Configure build:
   - Framework preset: None
   - Build command: `npm run build`
   - Build output directory: `build`
   - Node version: `20`
3. Deploy

### _redirects file
Create `static/_redirects`:
```
/old-page /new-page 301
/* /index.html 200
```

---

## Docker

### Dockerfile
```dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### nginx.conf
```nginx
events {
  worker_connections 1024;
}

http {
  include /etc/nginx/mime.types;
  default_type application/octet-stream;

  server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    # SPA routing
    location / {
      try_files $uri $uri/ /index.html;
    }

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
      expires 1y;
      add_header Cache-Control "public, immutable";
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
  }
}
```

### Build & Run
```bash
docker build -t my-docs .
docker run -p 8080:80 my-docs
```

---

## Environment Variables

### Available at Build Time

```typescript
// docusaurus.config.ts
const config = {
  customFields: {
    apiUrl: process.env.API_URL || 'https://api.example.com',
    version: process.env.npm_package_version,
  },
};
```

### Access in Components
```jsx
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';

function MyComponent() {
  const {siteConfig} = useDocusaurusContext();
  const {apiUrl} = siteConfig.customFields;
  return <div>API: {apiUrl}</div>;
}
```

### Common Environment Variables

| Variable | Purpose |
|----------|---------|
| `NODE_ENV` | `production` or `development` |
| `URL` | Site URL override |
| `BASE_URL` | Base path override |
| `GIT_USER` | GitHub username for deploy |
| `USE_SSH` | Use SSH for GitHub deploy |
| `CURRENT_BRANCH` | Git branch name |

### .env Files (Local Development)

Create `.env.local` (gitignored):
```bash
API_URL=http://localhost:3001
DEBUG=true
```

Access via `process.env.API_URL` in config.

---

## CI/CD Best Practices

### Cache Dependencies
```yaml
# GitHub Actions
- uses: actions/cache@v3
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

### Build Checks
```yaml
- name: Check for broken links
  run: npm run build 2>&1 | tee build.log
  continue-on-error: false
```

### Preview Deployments
Most platforms (Vercel, Netlify, Cloudflare) automatically create preview URLs for PRs.

### Scheduled Rebuilds
```yaml
# Rebuild daily for fresh content
on:
  schedule:
    - cron: '0 0 * * *'
```
