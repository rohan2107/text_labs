#!/usr/bin/env bash
# Pull new labs from upstream and copy blank worksheets to the worksheets/ directory.
# Run this at the start of each week: bash pull_new_labs.sh

set -e

echo "Fetching upstream..."
git fetch upstream

echo "Merging upstream/main..."
git merge upstream/main --no-edit

echo "Copying new labs to worksheets/..."
copied=0
for f in [0-9]_*.ipynb; do
    # Skip answer files
    [[ "$f" == *_answers* ]] && continue

    dest="worksheets/$f"
    if [[ ! -f "$dest" ]]; then
        cp "$f" "$dest"
        echo "  Copied: $f -> $dest"
        ((copied++))
    fi
done

if [[ $copied -eq 0 ]]; then
    echo "  No new labs found."
else
    echo "Done. $copied new lab(s) copied to worksheets/."
fi
