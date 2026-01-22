# CLAUDE.md

Instructions for Claude Code when working in this repository.

## Project Context

This is a skills repository for AI coding agents, specifically providing a comprehensive Docusaurus skill. The skill helps agents manage Docusaurus documentation sites efficiently.

## Key Files

- `skills/docusaurus/SKILL.md` - Main skill definition (keep under 500 lines)
- `skills/docusaurus/references/` - Detailed reference documentation
- `skills/docusaurus/scripts/` - Helper bash scripts

## Development Guidelines

### Editing SKILL.md

1. Keep it concise - this loads into context when activated
2. Use tables for quick reference
3. Link to reference files for detailed content
4. Include practical examples over verbose explanations

### Adding Reference Files

1. Start with a Table of Contents for files >100 lines
2. Use consistent heading hierarchy
3. Include complete code examples
4. Cover edge cases and common pitfalls

### Script Requirements

1. Use `#!/bin/bash` and `set -e`
2. Write status messages to stderr: `echo "message" >&2`
3. Output JSON to stdout for agent consumption
4. Include usage examples in comments

## Testing

To test the skill:
```bash
# Copy to Claude skills directory
cp -r skills/docusaurus ~/.claude/skills/

# Test on a Docusaurus project
cd /path/to/docusaurus-project
# Then use Claude Code and work on Docusaurus tasks
```

## Packaging

Create distribution package:
```bash
cd skills
zip -r docusaurus.zip docusaurus/
```

## Commit Guidelines

- Sign commits: `git commit -s -m "message"`
- Use conventional commits: `feat:`, `fix:`, `docs:`, `chore:`
- Keep commits focused and atomic
