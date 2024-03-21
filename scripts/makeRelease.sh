#!/usr/bin/env bash
# exit if any cmd fails

if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
	# The script is sourced, use return instead
	echo "Do not source, otherwise will exit the terminal; run as ./script or bash script"
	return;
fi

set -e

# Check args
if [ $# -ne 2 ]; then
    echo "Usage: [major | minor | patch] [version note]"
    exit
fi

# Check if the second argument is 'major', 'minor', or 'patch'
if [[ $1 != "major" && $1 != "minor" && $1 != "patch" ]]; then
    echo "Error: Second argument must be 'major', 'minor', or 'patch' received ${2}"
    exit
fi

# Check if the current branch is "main"
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" != "main" ]; then
    echo "You are not on the 'main' branch. Current branch is $current_branch."
    exit
fi

# check working dir clean
if ! git diff-index --quiet HEAD --; then
    echo "The working directory is not clean."
    echo "Please commit or stash your changes before proceeding."
    exit
fi

set -x

yarn prod_all
yarn version "$1"
# as of yarn v2+ seem to need to run both
yarn run version

# Extracting the version using jq
version=$(jq -r '.version' manifest.json)
if [ -z "$version" ]; then
    echo "Error: Version not found in manifest.json."
    exit
fi

git tag "$version"
git push origin "$version"

gh release create "$version" ./build/* --title "Version $version" --notes "$2"

cleanup() {
    echo "Cleaning up"
    set +e
    set +x
}

trap cleanup EXIT
