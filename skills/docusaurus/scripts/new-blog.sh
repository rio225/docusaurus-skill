#!/bin/bash
set -e

# Create a new Docusaurus blog post
# Usage: ./new-blog.sh <slug> [title] [author]
# Example: ./new-blog.sh my-first-post "My First Post" vipul

SLUG="${1:-}"
TITLE="${2:-}"
AUTHOR="${3:-}"

if [ -z "$SLUG" ]; then
  echo "Usage: $0 <slug> [title] [author]" >&2
  echo "Example: $0 my-first-post \"My First Post\" vipul" >&2
  exit 1
fi

# Find blog directory
BLOG_DIR=""
for dir in "blog" "content/blog"; do
  if [ -d "$dir" ]; then
    BLOG_DIR="$dir"
    break
  fi
done

if [ -z "$BLOG_DIR" ]; then
  echo "Warning: Blog directory not found, creating 'blog/'" >&2
  BLOG_DIR="blog"
  mkdir -p "$BLOG_DIR"
fi

# Generate date prefix
DATE=$(date +%Y-%m-%d)

# Construct filename
FILENAME="$DATE-$SLUG.md"
FULL_PATH="$BLOG_DIR/$FILENAME"

# Generate title from slug if not provided
if [ -z "$TITLE" ]; then
  TITLE=$(echo "$SLUG" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
fi

# Check if file already exists
if [ -f "$FULL_PATH" ]; then
  echo "Error: File already exists: $FULL_PATH" >&2
  exit 1
fi

# Build authors line
AUTHORS_LINE=""
if [ -n "$AUTHOR" ]; then
  AUTHORS_LINE="authors: [$AUTHOR]"
else
  AUTHORS_LINE="authors:
  - name: Your Name
    title: Your Title
    url: https://github.com/username
    image_url: https://github.com/username.png"
fi

# Create the blog post
cat > "$FULL_PATH" << EOF
---
title: "$TITLE"
description: "TODO: Add compelling description for SEO and social sharing"
slug: $SLUG
$AUTHORS_LINE
tags:
  - announcement
image: /img/blog/$SLUG-og.png
hide_table_of_contents: false
---

Write a compelling intro paragraph here. This appears in the blog list.

{/* truncate */}

## The Full Story

Your detailed content goes here.

### Section 1

Content for section 1.

### Section 2

Content for section 2.

## Conclusion

Wrap up your thoughts here.

---

*Have questions? Drop a comment below or reach out on [Twitter](https://twitter.com/username).*
EOF

echo "Created: $FULL_PATH" >&2

# Output JSON for agent consumption
cat << EOF
{
  "success": true,
  "path": "$FULL_PATH",
  "title": "$TITLE",
  "slug": "$SLUG",
  "date": "$DATE",
  "message": "Blog post created successfully"
}
EOF
