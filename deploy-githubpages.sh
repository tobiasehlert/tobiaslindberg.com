#!/bin/sh

# If a command fails then the deploy stops
set -e

# Defining some vars
export GITHUB_PAGE="tobiasehlert.github.io"
export HUGO_ENVIRONMENT="githubpages"

# Set required git environment flags.
export GIT_COMMIT_SHA=`git rev-parse --verify HEAD`
export GIT_COMMIT_SHA_SHORT=`git rev-parse --short HEAD`


#
# STARTING SCRIPT
#

# Printing that we start with deployment
printf "\033[0;32mDeploying updates to GitHub Pages ($GITHUB_PAGE)...\033[0m\n"

# Editiing README.md to update GIT COMMIT SHA info
sed -i "s/> Commit SHA: .*/> Commit SHA: \*\*$GIT_COMMIT_SHA\*\* \[\[$GIT_COMMIT_SHA_SHORT\]\(https:\/\/github.com\/tobiasehlert\/tobiaslindberg.com\/commit\/$GIT_COMMIT_SHA\)\]/g" public-$GITHUB_PAGE/README.md

# Build the project,
hugo-extended --minify --gc --environment $HUGO_ENVIRONMENT

# Go To Public folder
cd public-$GITHUB_PAGE

# Add changes to git.
git add .

# Commit changes.
msg="$GITHUB_PAGE | commit $GIT_COMMIT_SHA_SHORT | generated $(date '+%Y-%m-%d %H:%M:%S')"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Printing that we are finished with deployment
printf "\033[0;32mDeployment completed!\033[0m\n"
