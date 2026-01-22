# Site Configuration Reference

Complete guide to `docusaurus.config.ts` options.

## Table of Contents
- [Core Configuration](#core-configuration)
- [Preset Configuration](#preset-configuration)
- [Theme Configuration](#theme-configuration)
- [Navbar Configuration](#navbar-configuration)
- [Footer Configuration](#footer-configuration)
- [Plugins](#plugins)
- [SEO & Metadata](#seo--metadata)

---

## Core Configuration

```typescript
import type {Config} from '@docusaurus/types';

const config: Config = {
  // Required
  title: 'My Site',
  url: 'https://example.com',

  // Recommended
  tagline: 'Dinosaurs are cool',
  favicon: 'img/favicon.ico',
  baseUrl: '/',

  // GitHub Pages specific
  organizationName: 'facebook',
  projectName: 'docusaurus',
  deploymentBranch: 'gh-pages',
  trailingSlash: false,

  // Build behavior
  onBrokenLinks: 'throw',        // 'ignore' | 'log' | 'warn' | 'throw'
  onBrokenMarkdownLinks: 'warn',
  onBrokenAnchors: 'warn',
  onDuplicateRoutes: 'warn',

  // Internationalization
  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'fr', 'ja'],
    localeConfigs: {
      en: { label: 'English', htmlLang: 'en-US' },
      fr: { label: 'Français', htmlLang: 'fr-FR' },
    },
  },

  // Future flags (experimental)
  future: {
    experimental_faster: {
      swcJsLoader: true,
      swcJsMinimizer: true,
      swcHtmlMinimizer: true,
      lightningCssMinimizer: true,
      mdxCrossCompilerCache: true,
    },
  },

  // Markdown options
  markdown: {
    format: 'mdx',          // 'mdx' | 'md' | 'detect'
    mermaid: true,
    mdx1Compat: {
      comments: true,
      admonitions: true,
      headingIds: true,
    },
  },

  // Custom scripts
  scripts: [
    'https://example.com/script.js',
    { src: '/js/custom.js', async: true },
  ],

  // Custom stylesheets
  stylesheets: [
    'https://fonts.googleapis.com/css2?family=Inter',
    { href: '/css/custom.css', type: 'text/css' },
  ],

  // Custom head tags
  headTags: [
    {
      tagName: 'link',
      attributes: { rel: 'preconnect', href: 'https://fonts.gstatic.com' },
    },
    {
      tagName: 'script',
      attributes: { type: 'application/ld+json' },
      innerHTML: JSON.stringify({ '@context': 'https://schema.org', ... }),
    },
  ],

  // Presets and plugins (see below)
  presets: [...],
  plugins: [...],
  themes: [...],
  themeConfig: {...},
};

export default config;
```

---

## Preset Configuration

### Classic Preset (Most Common)

```typescript
presets: [
  [
    'classic',
    {
      // Docs plugin options
      docs: {
        sidebarPath: './sidebars.js',
        editUrl: 'https://github.com/org/repo/edit/main/',
        routeBasePath: 'docs',      // Set to '/' for docs-only mode
        path: 'docs',
        include: ['**/*.md', '**/*.mdx'],
        exclude: ['**/_*.md'],
        showLastUpdateAuthor: true,
        showLastUpdateTime: true,
        breadcrumbs: true,
        versions: {
          current: { label: 'Next', path: 'next' },
        },
      },

      // Blog plugin options
      blog: {
        showReadingTime: true,
        editUrl: 'https://github.com/org/repo/edit/main/',
        blogTitle: 'Blog',
        blogDescription: 'Our blog',
        blogSidebarTitle: 'Recent posts',
        blogSidebarCount: 'ALL',    // number | 'ALL'
        postsPerPage: 10,
        path: 'blog',
        routeBasePath: 'blog',
        feedOptions: {
          type: 'all',              // 'rss' | 'atom' | 'json' | 'all'
          copyright: `Copyright © ${new Date().getFullYear()}`,
        },
      },

      // Theme options
      theme: {
        customCss: './src/css/custom.css',
      },

      // Google Analytics
      gtag: {
        trackingID: 'G-XXXXXXXXXX',
        anonymizeIP: true,
      },

      // Google Tag Manager
      googleTagManager: {
        containerId: 'GTM-XXXXXXX',
      },

      // Sitemap
      sitemap: {
        changefreq: 'weekly',
        priority: 0.5,
        ignorePatterns: ['/tags/**'],
        filename: 'sitemap.xml',
      },

      // Pages plugin (auto-included)
      pages: {
        path: 'src/pages',
        routeBasePath: '',
        include: ['**/*.{js,jsx,ts,tsx,md,mdx}'],
      },
    },
  ],
],
```

### Docs-Only Mode

```typescript
docs: {
  routeBasePath: '/',  // Serve docs at root
},
blog: false,  // Disable blog
```

---

## Theme Configuration

```typescript
themeConfig: {
  // Color mode
  colorMode: {
    defaultMode: 'light',           // 'light' | 'dark'
    disableSwitch: false,
    respectPrefersColorScheme: true,
  },

  // Announcement bar
  announcementBar: {
    id: 'announcement',
    content: 'We released v2.0! <a href="/blog/v2">Read more</a>',
    backgroundColor: '#fafbfc',
    textColor: '#091E42',
    isCloseable: true,
  },

  // Docs sidebar
  docs: {
    sidebar: {
      hideable: true,
      autoCollapseCategories: true,
    },
  },

  // Table of contents
  tableOfContents: {
    minHeadingLevel: 2,
    maxHeadingLevel: 4,
  },

  // Code highlighting
  prism: {
    theme: prismThemes.github,
    darkTheme: prismThemes.dracula,
    additionalLanguages: ['bash', 'json', 'yaml', 'typescript'],
    defaultLanguage: 'javascript',
    magicComments: [
      {
        className: 'theme-code-block-highlighted-line',
        line: 'highlight-next-line',
        block: { start: 'highlight-start', end: 'highlight-end' },
      },
    ],
  },

  // Social card default
  image: 'img/og-image.png',

  // Global metadata
  metadata: [
    { name: 'keywords', content: 'documentation, tutorial' },
    { name: 'twitter:card', content: 'summary_large_image' },
  ],

  // Navbar (see below)
  navbar: {...},

  // Footer (see below)
  footer: {...},

  // Algolia search
  algolia: {
    appId: 'YOUR_APP_ID',
    apiKey: 'YOUR_SEARCH_API_KEY',
    indexName: 'YOUR_INDEX_NAME',
    contextualSearch: true,
    searchParameters: {},
    searchPagePath: 'search',
  },
},
```

---

## Navbar Configuration

```typescript
navbar: {
  title: 'My Site',
  logo: {
    alt: 'Site Logo',
    src: 'img/logo.svg',
    srcDark: 'img/logo-dark.svg',  // Dark mode logo
    href: '/',
    target: '_self',
    width: 32,
    height: 32,
    className: 'custom-logo-class',
  },
  hideOnScroll: false,
  style: 'dark',  // 'primary' | 'dark' | undefined

  items: [
    // Doc sidebar link
    {
      type: 'docSidebar',
      sidebarId: 'docs',
      label: 'Docs',
      position: 'left',
    },

    // Single doc link
    {
      type: 'doc',
      docId: 'intro',
      label: 'Tutorial',
      position: 'left',
    },

    // Internal link
    {
      to: '/blog',
      label: 'Blog',
      position: 'left',
    },

    // External link
    {
      href: 'https://github.com/org/repo',
      label: 'GitHub',
      position: 'right',
    },

    // Dropdown menu
    {
      type: 'dropdown',
      label: 'Community',
      position: 'left',
      items: [
        { label: 'Discord', href: 'https://discord.gg/xxx' },
        { label: 'Twitter', href: 'https://twitter.com/xxx' },
        { type: 'doc', docId: 'contributing', label: 'Contributing' },
      ],
    },

    // Version dropdown
    {
      type: 'docsVersionDropdown',
      position: 'right',
      dropdownActiveClassDisabled: true,
    },

    // Locale dropdown
    {
      type: 'localeDropdown',
      position: 'right',
    },

    // Search
    {
      type: 'search',
      position: 'right',
    },

    // Custom HTML (icon links)
    {
      href: 'https://github.com/org/repo',
      position: 'right',
      className: 'header-github-link',
      'aria-label': 'GitHub repository',
    },
  ],
},
```

---

## Footer Configuration

```typescript
footer: {
  style: 'dark',  // 'dark' | 'light'
  logo: {
    alt: 'Logo',
    src: 'img/logo.svg',
    href: 'https://example.com',
    width: 160,
    height: 51,
  },

  links: [
    {
      title: 'Docs',
      items: [
        { label: 'Tutorial', to: '/docs/intro' },
        { label: 'API', to: '/docs/api' },
      ],
    },
    {
      title: 'Community',
      items: [
        { label: 'Stack Overflow', href: 'https://stackoverflow.com/questions/tagged/docusaurus' },
        { label: 'Discord', href: 'https://discordapp.com/invite/docusaurus' },
      ],
    },
    {
      title: 'More',
      items: [
        { label: 'Blog', to: '/blog' },
        { label: 'GitHub', href: 'https://github.com/org/repo' },
      ],
    },
  ],

  copyright: `Copyright © ${new Date().getFullYear()} My Project. Built with Docusaurus.`,
},
```

---

## Plugins

### Common Plugins

```typescript
plugins: [
  // SASS support
  'docusaurus-plugin-sass',

  // Client-side redirects
  [
    '@docusaurus/plugin-client-redirects',
    {
      redirects: [
        { from: '/old-page', to: '/new-page' },
        { from: ['/old-1', '/old-2'], to: '/new' },
      ],
      createRedirects(existingPath) {
        if (existingPath.includes('/docs/')) {
          return [existingPath.replace('/docs/', '/documentation/')];
        }
        return undefined;
      },
    },
  ],

  // PWA support
  [
    '@docusaurus/plugin-pwa',
    {
      debug: false,
      offlineModeActivationStrategies: ['appInstalled', 'standalone', 'queryString'],
      pwaHead: [
        { tagName: 'link', rel: 'manifest', href: '/manifest.json' },
        { tagName: 'meta', name: 'theme-color', content: '#000000' },
      ],
    },
  ],

  // Image optimization
  [
    '@docusaurus/plugin-ideal-image',
    {
      quality: 85,
      max: 1030,
      min: 640,
      steps: 2,
      disableInDev: false,
    },
  ],

  // Custom plugin (local)
  './src/plugins/my-plugin',
],
```

---

## SEO & Metadata

### Page-level SEO (Frontmatter)
```yaml
---
title: Page Title
description: Page description for search engines
keywords: [keyword1, keyword2]
image: /img/page-og.png
---
```

### Global Metadata
```typescript
themeConfig: {
  metadata: [
    { name: 'keywords', content: 'docs, tutorial, guide' },
    { name: 'twitter:card', content: 'summary_large_image' },
    { property: 'og:image', content: '/img/og-image.png' },
  ],
},
```

### Structured Data (JSON-LD)
```typescript
headTags: [
  {
    tagName: 'script',
    attributes: { type: 'application/ld+json' },
    innerHTML: JSON.stringify({
      '@context': 'https://schema.org',
      '@type': 'Organization',
      name: 'My Company',
      url: 'https://example.com',
      logo: 'https://example.com/img/logo.png',
    }),
  },
],
```
