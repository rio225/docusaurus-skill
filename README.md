# Docusaurus Skill

> The definitive AI agent skill for managing Docusaurus documentation sites.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Skills.sh](https://img.shields.io/badge/skills.sh-listed-brightgreen)](https://skills.sh)
[![Docusaurus](https://img.shields.io/badge/Docusaurus-3.x-green)](https://docusaurus.io)

Built from experience managing **30+ Docusaurus sites**. Stop wrestling with configs. Start shipping docs.

## What This Skill Does

Transform your AI coding agent into a Docusaurus expert:

| Task | Before | After |
|------|--------|-------|
| Create doc page | Google frontmatter fields, copy-paste templates | `"Create a getting started guide"` |
| Configure sidebar | Read docs, trial-and-error | `"Add this to the API section"` |
| Set up blog | Configure authors, tags, feeds manually | `"Set up a blog with RSS"` |
| Deploy | Research platform-specific configs | `"Deploy to Vercel"` |

## Quick Start

### Installation

**Via skills.sh (Recommended):**
```bash
npx skills add vipulgupta2048/docusaurus-skill
```

**Claude Code / Claude Desktop:**
```bash
# Clone and copy to skills directory
git clone https://github.com/vipulgupta2048/docusaurus-skill.git
cp -r docusaurus-skill/skills/docusaurus ~/.claude/skills/
```

**Claude.ai Projects:**
1. Download `skills/docusaurus/SKILL.md`
2. Add to your project's knowledge base

### Usage

Once installed, the skill activates automatically when you work on Docusaurus projects. Just ask naturally:

```
"Create a new doc page called Authentication Guide"
"Add a category for API Reference in the sidebar"
"Set up a blog with author profiles"
"Help me configure Algolia search"
"Deploy this to GitHub Pages"
```

## Features

### Documentation Management
- Create pages with proper frontmatter
- Organize with categories and generated indexes
- Handle MDX components (admonitions, tabs, code blocks)
- Manage internal linking and navigation

### Blog System
- Set up authors.yml with profiles
- Create posts with tags and images
- Configure RSS/Atom feeds
- Multiple blog support

### Site Configuration
- Navbar and footer customization
- Theme and plugin setup
- SEO optimization (meta tags, structured data)
- Search integration (Algolia)

### Deployment
- GitHub Pages with Actions workflow
- Vercel (auto-detect)
- Netlify with redirects
- Cloudflare Pages
- Docker containerization

## Skill Contents

```
skills/docusaurus/
├── SKILL.md                    # Core instructions (loaded on activation)
├── metadata.json               # Skill metadata
├── references/                 # Detailed documentation
│   ├── frontmatter.md          # All frontmatter fields
│   ├── sidebar-config.md       # Sidebar patterns
│   ├── mdx-features.md         # MDX syntax and components
│   ├── config-options.md       # docusaurus.config.ts
│   ├── blog-config.md          # Blog setup
│   └── deployment.md           # Platform guides
└── scripts/                    # Helper scripts
    ├── new-doc.sh              # Create doc page
    ├── new-blog.sh             # Create blog post
    └── validate.sh             # Validate site
```

## Why This Skill?

### Context-Efficient Design
- **SKILL.md** is under 200 lines - loads fast, leaves room for your code
- **References** load only when needed - deep documentation on demand
- **Scripts** execute without reading - deterministic operations

### Battle-Tested
Built from managing documentation for:
- Multi-product documentation portals
- Open-source project docs
- Company knowledge bases
- Developer documentation at scale

### Always Current
Maintained against Docusaurus 3.x with regular updates for new features.

## Supported Platforms

| Platform | Status |
|----------|--------|
| Claude Code | ✅ Full support |
| Claude Desktop | ✅ Full support |
| Cursor | ✅ Compatible |
| Windsurf | ✅ Compatible |
| GitHub Copilot | ✅ Compatible |
| Other agents | ⚡ Works with SKILL.md |

## Contributing

Contributions welcome! See [AGENTS.md](AGENTS.md) for development guidelines.

```bash
# Clone the repo
git clone https://github.com/vipulgupta2048/docusaurus-skill.git
cd docusaurus-skill

# Make changes to skills/docusaurus/

# Test locally
cp -r skills/docusaurus ~/.claude/skills/

# Package for distribution
cd skills && zip -r docusaurus.zip docusaurus/
```

## Related

- [Docusaurus Documentation](https://docusaurus.io/docs)
- [skills.sh Directory](https://skills.sh)
- [Agent Skills Format](https://agentskills.io)

## License

MIT - Use it, fork it, improve it.

---

**Built with caffeine and documentation obsession by [@vipulgupta2048](https://github.com/vipulgupta2048)**

*Managing docs at scale? Let's talk: [vipulgupta2048@gmail.com](mailto:vipulgupta2048@gmail.com)*
