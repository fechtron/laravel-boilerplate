#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: No branch name provided."
    echo "Usage: $0 <new-branch-name>"
    exit 1
fi

git checkout -b "$1"
git add .
git commit -m "New branch created $1"
# git push -u origin "$1"

exit 0