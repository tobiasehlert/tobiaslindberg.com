#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub Pages (tobiaslindberg.github.io)...\033[0m\n"

# Build the project.
hugo-extended --minify --gc --baseURL=https://tobiaslindberg.github.io/

# Go To Public folder
cd docs

# Add changes to git.
git add .

# Commit changes.
msg="Rebuilding of tobiaslindberg.github.io $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
