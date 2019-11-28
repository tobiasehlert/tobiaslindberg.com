#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub Pages (tobiasehlert.github.io)...\033[0m\n"

# Build the project.
hugo-extended --minify --gc --environment  githubpages

# Go To Public folder
cd tobiasehlert.github.io

# Add changes to git.
git add .

# Commit changes.
msg="Generated tobiasehlert.github.io at $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
