# Blog Configuration Reference

Complete guide to Docusaurus blog setup and configuration.

## Table of Contents
- [Blog Plugin Options](#blog-plugin-options)
- [Authors Configuration](#authors-configuration)
- [Blog Post Structure](#blog-post-structure)
- [Tags Configuration](#tags-configuration)
- [Multiple Blogs](#multiple-blogs)
- [Blog-Only Mode](#blog-only-mode)

---

## Blog Plugin Options

```typescript
// In docusaurus.config.ts preset
blog: {
  // Paths
  path: 'blog',                    // Blog content directory
  routeBasePath: 'blog',           // URL base path

  // Display options
  blogTitle: 'Blog',               // Page title
  blogDescription: 'A blog',       // Meta description
  blogSidebarTitle: 'Recent posts',
  blogSidebarCount: 'ALL',         // number | 'ALL'
  postsPerPage: 10,                // Posts per page (or 'ALL')
  showReadingTime: true,

  // Author options
  authorsMapPath: 'authors.yml',   // Default: 'authors.yml'

  // Editing
  editUrl: 'https://github.com/org/repo/edit/main/',
  editLocalizedFiles: false,

  // File patterns
  include: ['**/*.{md,mdx}'],
  exclude: [
    '**/_*.{md,mdx}',
    '**/_*/**',
    '**/*.test.{js,jsx,ts,tsx}',
  ],

  // Truncation
  truncateMarker: /<!--\s*(truncate)\s*-->/,

  // Feed options
  feedOptions: {
    type: 'all',                   // 'rss' | 'atom' | 'json' | 'all' | null
    title: 'My Blog Feed',
    description: 'Latest posts',
    copyright: `Copyright © ${new Date().getFullYear()}`,
    language: 'en',
    limit: 20,                     // Number of posts in feed
    createFeedItems: async (params) => {
      const {blogPosts, defaultCreateFeedItems, ...rest} = params;
      return defaultCreateFeedItems({
        blogPosts: blogPosts.filter((item, index) => index < 10),
        ...rest,
      });
    },
  },

  // Reading time customization
  readingTime: ({content, frontMatter, defaultReadingTime}) =>
    frontMatter.hide_reading_time
      ? undefined
      : defaultReadingTime({content, options: {wordsPerMinute: 300}}),

  // Sorting
  sortPosts: 'descending',         // 'descending' | 'ascending'

  // Archive
  archiveBasePath: 'archive',      // Set to null to disable

  // Tags
  tagsBasePath: 'tags',

  // Callbacks
  beforeDefaultRemarkPlugins: [],
  beforeDefaultRehypePlugins: [],
  remarkPlugins: [],
  rehypePlugins: [],
},
```

---

## Authors Configuration

### authors.yml Structure

Create `blog/authors.yml`:

```yaml
# Simple author
vipul:
  name: Vipul Gupta
  title: Developer & Community Builder
  url: https://github.com/vipulgupta2048
  image_url: https://github.com/vipulgupta2048.png

# Author with all fields
alice:
  name: Alice Johnson
  title: Technical Writer
  url: https://alice.dev
  image_url: /img/authors/alice.png
  email: alice@example.com
  page: true  # Generate author page at /blog/authors/alice
  socials:
    twitter: alicejohnson
    github: alice
    linkedin: alice-johnson
    stackoverflow: 12345/alice

# Organization/team author
team:
  name: Documentation Team
  title: Collective Contributors
  image_url: /img/authors/team.png
  url: https://github.com/orgs/myorg/teams/docs
```

### Using Authors in Posts

**Single author (from authors.yml):**
```yaml
---
authors: vipul
---
```

**Multiple authors:**
```yaml
---
authors: [vipul, alice]
---
```

**Inline author (one-time):**
```yaml
---
authors:
  name: Guest Author
  title: External Contributor
  url: https://guest.dev
  image_url: https://guest.dev/avatar.png
---
```

**Mixed (global + inline):**
```yaml
---
authors:
  - vipul
  - name: Guest Author
    title: Special Contributor
    image_url: /img/guest.png
---
```

---

## Blog Post Structure

### File Naming Conventions

```
blog/
├── 2024-01-15-my-first-post.md       # Date in filename
├── 2024-01-20-another-post/          # Folder with assets
│   ├── index.md
│   └── image.png
├── my-undated-post.md                # No date (uses file date)
└── authors.yml
```

### Complete Blog Post Example

```markdown
---
title: "Building Better Documentation with AI"
description: "How AI tools are transforming the way we write and maintain documentation"
slug: ai-documentation-revolution
date: 2024-01-15T10:00:00Z
authors:
  - vipul
  - name: AI Documentation Team
    title: Contributors
    image_url: /img/ai-team.png
tags:
  - ai
  - documentation
  - tooling
image: /img/blog/ai-docs-og.png
hide_table_of_contents: false
draft: false
---

The intro paragraph appears in the blog list. Keep it compelling!

{/* truncate */}

## The Full Story

Everything below the truncate marker only appears on the full post page.

### Using Images

![AI Writing](./ai-writing.png)

### Code Examples

```python
def document_with_ai(content):
    """AI-assisted documentation."""
    return enhance(content)
```

## Conclusion

Wrap up your thoughts here.
```

### Truncation Methods

**HTML comment (recommended):**
```markdown
Intro text here.

<!--truncate-->

Full content here.
```

**MDX comment:**
```mdx
Intro text here.

{/* truncate */}

Full content here.
```

---

## Tags Configuration

### Defining Tags

Tags are automatically created from blog post frontmatter:

```yaml
---
tags: [react, tutorial, beginner]
---
```

### Custom Tags File (Optional)

Create `blog/tags.yml` for tag metadata:

```yaml
react:
  label: React
  description: Posts about React development
  permalink: /react

tutorial:
  label: Tutorials
  description: Step-by-step guides
  permalink: /tutorials
```

### Tag Pages

Docusaurus auto-generates:
- `/blog/tags` - All tags page
- `/blog/tags/react` - Posts with "react" tag

---

## Multiple Blogs

### Configuration

```typescript
// docusaurus.config.ts
plugins: [
  [
    '@docusaurus/plugin-content-blog',
    {
      id: 'engineering-blog',
      routeBasePath: 'engineering',
      path: './engineering-blog',
      blogTitle: 'Engineering Blog',
      blogDescription: 'Technical deep-dives',
      authorsMapPath: 'authors.yml',
    },
  ],
  [
    '@docusaurus/plugin-content-blog',
    {
      id: 'company-news',
      routeBasePath: 'news',
      path: './company-news',
      blogTitle: 'Company News',
      blogDescription: 'Updates and announcements',
    },
  ],
],
```

### Directory Structure

```
project/
├── blog/                    # Main blog (from preset)
│   └── authors.yml
├── engineering-blog/        # Engineering blog
│   ├── authors.yml
│   └── 2024-01-15-post.md
└── company-news/            # News blog
    └── 2024-01-15-news.md
```

---

## Blog-Only Mode

### Serve Blog at Root

```typescript
// docusaurus.config.ts
presets: [
  [
    'classic',
    {
      docs: false,  // Disable docs
      blog: {
        routeBasePath: '/',  // Blog at root
        blogSidebarTitle: 'All posts',
        blogSidebarCount: 'ALL',
      },
    },
  ],
],
```

### Set Blog as Homepage

```typescript
blog: {
  routeBasePath: '/',
},
// Remove or redirect src/pages/index.js
```

---

## RSS/Atom Feed URLs

Once configured, feeds are available at:
- RSS: `/blog/rss.xml`
- Atom: `/blog/atom.xml`
- JSON: `/blog/feed.json`

For multiple blogs:
- `/engineering/rss.xml`
- `/news/rss.xml`
