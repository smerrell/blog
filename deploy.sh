#!/usr/bin/env bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo -t hugo-cactus-theme # if using a theme, replace with `hugo -t <YOURTHEME>`

if [ $? -ne 0 ]; then
    echo -e "\033[0;31mDeploy failed!\033[0m"
    exit 1
fi

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="Rebuild site `date`"
if [ $# -eq 1 ]
    then msg="$1"
fi

git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
echo -e "\033[0;32mDeploy complete!\033[0m"
cd ..
