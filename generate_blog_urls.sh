#!/bin/bash

# This script checks git status for modified blog posts, extracts their slugs,
# and prints their corresponding website URLs.

BASE_URL="https://stefanogabryel.it/blog/"

# Get git status output, filter for modified or new index.md files in content/blog/
# Include both staged (M ) and unstaged ( M) modifications
modified_posts=$(git status --porcelain | grep -E '^(M | M|A |AM)\s+content/blog/.*index.md$' | awk '{print $2}')

if [ -z "$modified_posts" ]; then
    echo "No modified or new blog posts (index.md) found."
    exit 0
fi

echo "--- Modified Blog Post URLs ---"

# Loop through each modified post file path
for filepath in $modified_posts; do
    # Extract slug using grep and cut (simpler and more compatible)
    slug=$(grep '^slug = ' "$filepath" | head -1 | cut -d'"' -f2)

    if [ -n "$slug" ]; then
        echo "${BASE_URL}${slug}/"
    else
        echo "Warning: Could not extract slug from $filepath. Skipping." >&2
    fi
done

echo "-----------------------------"