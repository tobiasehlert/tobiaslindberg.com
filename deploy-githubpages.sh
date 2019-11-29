#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub Pages (tobiasehlert.github.io)...\033[0m\n"

# Set required git environment flags.
GIT_COMMIT_SHA=`git rev-parse --verify HEAD`
GIT_COMMIT_SHA_SHORT=`git rev-parse --short HEAD`

# Build the project,
hugo-extended --minify --gc --environment  githubpages

# Go To Public folder
cd public-tobiasehlert.github.io

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
