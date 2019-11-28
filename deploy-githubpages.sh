#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub Pages (tobiasehlert.github.io)...\033[0m\n"

# Build the project.
hugo-extended --minify --gc --baseURL https://tobiasehlert.github.io/ --enableGitInfo --environment production --destination tobiasehlert.github.io

# Go To Public folder
cd tobiasehlert.github.io

# Add changes to git.
git add .

# Commit changes.
msg="Generating new version of tobiasehlert.github.io $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
