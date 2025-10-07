#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: No commit message provided."
    echo "Usage: $0 <commit-message>"
    exit 1
fi

git add .
git commit -m "$1"
git push origin main
echo "Changes committed and pushed with message: '$1'"

exit 0
