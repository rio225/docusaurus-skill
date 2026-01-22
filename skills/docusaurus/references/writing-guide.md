# Writing Guide

Voice, tone, and language standards for documentation.

---

## Voice Principles

### Be Direct

Not: "It should be noted that the configuration file needs to be updated."
Yes: "Update the configuration file."

Not: "Users may find it helpful to restart the server."
Yes: "Restart the server."

### Address the Reader

Not: "Developers can use the API to..."
Yes: "Use the API to..."

Not: "One might consider..."
Yes: "Consider..."

### Present Tense, Active Voice

Not: "The file will be created when..."
Yes: "The file is created when..."

Not: "The request is processed by the server."
Yes: "The server processes the request."

---

## Words That Weaken

Remove these. They add nothing:

| Remove | Why |
|--------|-----|
| simply, just, easily | Implies difficulty is your fault |
| obviously, clearly | If it were obvious, you wouldn't write it |
| please | Unnecessary in instructions |
| in order to | "To" works |
| it is important to note that | Just state it |
| basically | Delete |
| actually | Delete |

**Before:** "Simply run the following command to easily set up..."
**After:** "Run the command to set up..."

---

## Inclusive Language

### Required Replacements

| Don't Use | Use Instead |
|-----------|-------------|
| whitelist / blacklist | allowlist / blocklist |
| master / slave | primary / replica, main / secondary |
| master branch | main branch |
| sanity check | confidence check, validation, smoke test |
| dummy (value/data) | placeholder, sample, test |
| cripple | disable, impair, limit |
| blind to | unaware of, ignoring |
| crazy, insane | unexpected, surprising, intense |
| man-hours | person-hours, engineering hours |
| manpower | workforce, staffing |
| guys | folks, everyone, team, y'all |
| he/she, his/her | they, their |
| normal users | typical users, most users |

### Writing About People

**Disability:**
- Not: "suffers from," "victim of," "wheelchair-bound"
- Yes: "has," "uses a wheelchair," "with [condition]"

**Age:**
- Not: "the elderly," "seniors"
- Yes: "older adults"

**Experience level:**
- Not: "for dummies," "idiot's guide"
- Yes: "introduction," "getting started"

### Cultural Sensitivity

- Avoid US-centric examples (Thanksgiving, Super Bowl, Fahrenheit)
- Use ISO date format: 2024-01-15, not 01/15/2024
- Use 24-hour time or specify timezone
- Don't assume everyone celebrates the same holidays

---

## Second Person "You"

Always address the reader directly:

Not: "The user should configure their settings."
Yes: "Configure your settings."

Not: "Developers will need to install..."
Yes: "Install..."

**When to use "we":**
- Only when the reader is genuinely working WITH you
- "We'll build this together" (in a collaborative tutorial)
- Never use "we" to mean "our company"

---

## Code in Prose

### Commands

Use backticks and be specific:

Not: "Run the build command."
Yes: "Run `npm run build`."

### Filenames and Paths

Always in backticks: `docusaurus.config.ts`, `src/pages/`

### Configuration Values

In backticks: Set `trailingSlash` to `false`.

### Placeholders

Use angle brackets and ALL_CAPS:

```bash
git clone https://github.com/<YOUR_USERNAME>/<REPO_NAME>
```

Not `{username}` or `$USERNAME` in documentation prose.

---

## Headings

### Capitalization

Use sentence case, not title case:

Not: "How To Configure Your Build Settings"
Yes: "How to configure your build settings"

### Parallel Structure

If one heading starts with a verb, they all should:

**Good:**
- Install dependencies
- Configure the project
- Deploy to production

**Bad:**
- Installation
- Configure the project
- Deploying to production

### Depth

Never go past H3 in a single page. If you need H4, the page is too complex—split it.

---

## Lists

### When to Use Bullets vs. Numbers

**Numbers:** When order matters (steps, priority)
**Bullets:** When order doesn't matter (features, options)

### List Formatting

Each item should be grammatically parallel:

**Good:**
- Configure the database
- Set up authentication
- Deploy the application

**Bad:**
- Database configuration
- Set up authentication
- The application should be deployed

### Sentence Fragments OK

In lists, sentence fragments are fine:

- Fast builds
- Hot reloading
- TypeScript support

---

## Examples

### Show, Don't Tell

Not: "The configuration accepts various options for customization."

Yes:
```javascript
{
  theme: 'dark',
  language: 'en',
}
```

### Minimal, Then Complete

Show the simplest working example first:

```javascript
// Minimal
{ name: 'my-project' }
```

Then show comprehensive:

```javascript
// With all options
{
  name: 'my-project',
  version: '1.0.0',
  // ...
}
```

### Comments in Code

Use comments to explain WHY, not WHAT:

```javascript
// Good: Explains reasoning
timeout: 30000, // Matches API's default request timeout

// Bad: States the obvious
timeout: 30000, // Set timeout to 30000
```

---

## Error Messages

When documenting errors:

1. Show the exact error message the user sees
2. Explain what caused it
3. Give the fix

```
Error: Cannot find module 'react'
```

**Cause:** Dependencies aren't installed.
**Fix:** Run `npm install` in your project directory.

---

## Checklist Before Publishing

- [ ] Title describes what the reader will DO
- [ ] Description is under 160 characters
- [ ] No "simple," "easy," "just," or "obviously"
- [ ] All code examples tested and working
- [ ] Links to related pages (no dead ends)
- [ ] Heading structure: H1 → H2 → H3 only
- [ ] Inclusive language throughout
