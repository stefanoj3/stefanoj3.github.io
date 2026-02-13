#!/bin/bash

# This script concatenates the raw content of all blog post index.md files
# into standard output, which can then be piped to pbcopy.

# No temporary file, no variable to accumulate within the loop.
# Instead, each piece of content is echoed directly.
rm allposts.txt
touch allposts.txt

find content/blog/ -name "index.md" | while read -r filepath; do
    # Add start delimiter with filepath
    echo "--- START OF POST: $filepath ---"

    # Append the raw content of the file
    cat "$filepath" >> allposts.txt

    # Add end delimiter with filepath
    echo "--- END OF POST: $filepath ---"
    echo "" # Add extra newline for separation
done