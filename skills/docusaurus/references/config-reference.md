# Configuration Reference

Essential `docusaurus.config.ts` options. Not exhaustive—see [Docusaurus docs](https://docusaurus.io/docs/api/docusaurus-config) for everything.

---

## Minimum Viable Config

```typescript
const config = {
  title: 'Project Name',
  url: 'https://docs.example.com',
  baseUrl: '/',

  presets: [
    ['classic', {
      docs: { routeBasePath: '/' },  // Docs at root
      blog: false,                    // Disable if not using
      theme: { customCss: './src/css/custom.css' },
    }],
  ],
};
```

My opinion: Start minimal. Add complexity only when you need it.

---

## The Options That Actually Matter

### Site Identity

```typescript
title: 'Your Project',           // Browser tab, search results
tagline: 'One sentence pitch',   // Shows in default homepage
favicon: 'img/favicon.ico',
```

### URLs

```typescript
url: 'https://docs.example.com', // Production URL (no trailing slash)
baseUrl: '/',                    // Usually '/' unless in subdirectory
trailingSlash: false,            // Pick one and stick with it
```

**Opinion:** `trailingSlash: false`. It's cleaner and most platforms handle it correctly.

### Build Behavior

```typescript
onBrokenLinks: 'throw',           // Fail build on broken links
onBrokenMarkdownLinks: 'throw',   // Same for markdown links
```

**Opinion:** Always `throw` in production. `warn` during development is OK.

---

## Preset: Classic (Use This)

```typescript
presets: [
  ['classic', {
    docs: {
      sidebarPath: './sidebars.ts',
      routeBasePath: '/',           // Docs as homepage
      editUrl: 'https://github.com/org/repo/edit/main/',
      showLastUpdateTime: true,     // Shows git commit time
    },
    blog: {
      showReadingTime: true,
      blogSidebarCount: 'ALL',
    },
    theme: {
      customCss: './src/css/custom.css',
    },
  }],
],
```

### Docs-Only Mode

Set `routeBasePath: '/'` and either `blog: false` or keep blog at `/blog`.

---

## Theme Config: What Readers See

### Navbar

```typescript
themeConfig: {
  navbar: {
    title: 'Project',
    logo: { alt: 'Logo', src: 'img/logo.svg' },
    items: [
      { type: 'docSidebar', sidebarId: 'docs', label: 'Docs' },
      { to: '/blog', label: 'Blog' },
      { href: 'https://github.com/...', label: 'GitHub', position: 'right' },
    ],
  },
}
```

**Opinion:** Keep navbar items under 5. More than that, use dropdowns.

### Color Mode

```typescript
colorMode: {
  defaultMode: 'light',           // Or 'dark'
  respectPrefersColorScheme: true, // Honor system preference
},
```

**Opinion:** Always `respectPrefersColorScheme: true`. Don't force your preference.

### Sidebar Behavior

```typescript
docs: {
  sidebar: {
    hideable: true,              // Let users collapse it
    autoCollapseCategories: true, // Only one category expanded
  },
},
```

### Search (Algolia)

```typescript
algolia: {
  appId: 'YOUR_APP_ID',
  apiKey: 'YOUR_SEARCH_API_KEY',  // Public search-only key
  indexName: 'YOUR_INDEX',
},
```

Apply at [Algolia DocSearch](https://docsearch.algolia.com/apply). It's free for open source.

---

## Plugins Worth Adding

### Client-Side Redirects

```typescript
plugins: [
  ['@docusaurus/plugin-client-redirects', {
    redirects: [
      { from: '/old-page', to: '/new-page' },
    ],
  }],
],
```

Use for moved pages. Don't leave 404s.

### Ideal Image

```typescript
['@docusaurus/plugin-ideal-image', {
  quality: 85,
  max: 1030,
  min: 640,
}],
```

Auto-generates responsive images. Worth it for image-heavy docs.

---

## Things I Never Configure

These defaults are fine:

- `i18n` (unless you actually have translations ready)
- `onDuplicateRoutes` (the default `warn` is fine)
- `staticDirectories` (default `static` works)
- `titleDelimiter` (the `|` is universal)

Don't add config for things you're not using. It's clutter.

---

## Config Anti-Patterns

**Don't:** Copy entire example configs and modify
**Do:** Start minimal, add what you need

**Don't:** Set `onBrokenLinks: 'ignore'` to "fix" build errors
**Do:** Actually fix the broken links

**Don't:** Add `customFields` unless you're using them in code
**Do:** Keep config lean

---

## Environment Variables

For values that change between environments:

```typescript
const config = {
  url: process.env.SITE_URL || 'http://localhost:3000',
  customFields: {
    apiUrl: process.env.API_URL,
  },
};
```

Access in components:
```javascript
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
const { siteConfig } = useDocusaurusContext();
const apiUrl = siteConfig.customFields.apiUrl;
```
