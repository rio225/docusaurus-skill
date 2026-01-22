#!/bin/bash
set -e

# Create a new Docusaurus documentation page
# Usage: ./new-doc.sh <doc-path> [title]
# Example: ./new-doc.sh guides/getting-started "Getting Started Guide"

DOC_PATH="${1:-}"
TITLE="${2:-}"

if [ -z "$DOC_PATH" ]; then
  echo "Usage: $0 <doc-path> [title]" >&2
  echo "Example: $0 guides/getting-started \"Getting Started Guide\"" >&2
  exit 1
fi

# Find docs directory
DOCS_DIR=""
for dir in "docs" "documentation" "content/docs"; do
  if [ -d "$dir" ]; then
    DOCS_DIR="$dir"
    break
  fi
done

if [ -z "$DOCS_DIR" ]; then
  echo "Error: Could not find docs directory" >&2
  exit 1
fi

# Construct full path
FULL_PATH="$DOCS_DIR/$DOC_PATH.md"

# Create parent directories if needed
mkdir -p "$(dirname "$FULL_PATH")"

# Generate title from path if not provided
if [ -z "$TITLE" ]; then
  TITLE=$(basename "$DOC_PATH" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
fi

# Generate slug from path
SLUG=$(basename "$DOC_PATH")

# Check if file already exists
if [ -f "$FULL_PATH" ]; then
  echo "Error: File already exists: $FULL_PATH" >&2
  exit 1
fi

# Create the doc file
cat > "$FULL_PATH" << EOF
---
title: "$TITLE"
description: "TODO: Add description for SEO"
sidebar_position: 1
---

# $TITLE

TODO: Add content here.

## Overview

Describe the purpose of this document.

## Prerequisites

List any prerequisites or requirements.

## Steps

1. First step
2. Second step
3. Third step

## Next Steps

- [Related Doc](./related-doc.md)
EOF

echo "Created: $FULL_PATH" >&2

# Output JSON for agent consumption
cat << EOF
{
  "success": true,
  "path": "$FULL_PATH",
  "title": "$TITLE",
  "message": "Documentation page created successfully"
}
EOF
