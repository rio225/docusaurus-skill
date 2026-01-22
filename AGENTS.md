# AGENTS.md

This file provides guidance to AI coding agents (Claude Code, Cursor, Copilot, Windsurf, etc.) when working with this repository.

## Repository Overview

A collection of skills for AI coding agents to work with Docusaurus documentation sites. Skills are packaged instructions and resources that extend agent capabilities for creating, editing, and managing Docusaurus projects.

## Available Skills

### docusaurus

Comprehensive Docusaurus site management skill covering:
- Creating and editing documentation pages
- Managing sidebars and navigation
- Configuring blogs and authors
- Site configuration (themes, plugins, SEO)
- MDX features (admonitions, tabs, code blocks)
- Deployment to various platforms

**Triggers:** Working with `.md/.mdx` files, `docusaurus.config.ts`, `sidebars.js`, or any Docusaurus-related task.

## Skill Structure

```
skills/
  docusaurus/
    SKILL.md              # Main skill instructions
    references/           # Detailed reference documentation
      frontmatter.md      # Doc/blog frontmatter fields
      sidebar-config.md   # Sidebar configuration patterns
      mdx-features.md     # MDX components and syntax
      config-options.md   # docusaurus.config.ts options
      blog-config.md      # Blog setup and configuration
      deployment.md       # Deployment guides
    scripts/              # Helper scripts
      new-doc.sh          # Create new documentation page
      new-blog.sh         # Create new blog post
      validate.sh         # Validate site for issues
```

## Using Skills

### Installation

**Claude Code / Claude Desktop:**
```bash
npx skills add vipulgupta2048/docusaurus-skill
```

**Manual installation:**
```bash
cp -r skills/docusaurus ~/.claude/skills/
```

**Claude.ai Projects:**
Add `skills/docusaurus/SKILL.md` to project knowledge.

### Invocation

Skills activate automatically when relevant tasks are detected. You can also explicitly invoke:
- `/docusaurus` - Load the Docusaurus skill

## Contributing

### Adding New Content

1. Reference files go in `skills/docusaurus/references/`
2. Scripts go in `skills/docusaurus/scripts/`
3. Keep SKILL.md under 500 lines; use references for detailed content

### Testing Changes

1. Copy skill to `~/.claude/skills/docusaurus`
2. Test with Claude Code on a real Docusaurus project
3. Verify all script outputs are valid JSON

### Packaging

After changes, create the distribution package:
```bash
cd skills
zip -r docusaurus.zip docusaurus/
```

## Best Practices for Context Efficiency

- **SKILL.md stays lean** - Only essential workflows and quick references
- **References for depth** - Detailed tables, examples, and configurations
- **Scripts for reliability** - Deterministic operations that don't consume context
- **Progressive disclosure** - Agent loads references only when needed
