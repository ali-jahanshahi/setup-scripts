#!/bin/bash

# Default repository link
DEFAULT_REPO_LINK="git@github.com:CentML/cserve.git"

# Check if the correct number of arguments is provided
if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 [<repository_link>] <branch_name>"
  exit 1
fi

# Assign arguments to variables
if [ "$#" -eq 2 ]; then
  REPO_LINK=$1
  BRANCH_NAME=$2
else
  REPO_LINK=$DEFAULT_REPO_LINK
  BRANCH_NAME=$1
fi

# Extract the repository name from the repository link
REPO_NAME=$(basename -s .git "$REPO_LINK")

# Replace slashes with hyphens in branch name to use as directory name
DIR_NAME="${REPO_NAME}_${BRANCH_NAME//\//-}"

# Clone the repository
git clone --branch "$BRANCH_NAME" "$REPO_LINK" "$DIR_NAME"

# Change directory to the cloned repository
cd "$DIR_NAME" || { echo "Failed to change directory to $DIR_NAME"; exit 1; }

# Check out the branch
git checkout "$BRANCH_NAME"