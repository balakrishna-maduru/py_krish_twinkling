#!/bin/bash

# Run test cases
pytest

# Get the current version from pyproject.toml
current_version=$(poetry version -s)

# Bump the version using bump2version (you can customize the part to bump: major, minor, or patch)
bump2version patch

# Get the new version
new_version=$(poetry version -s)

# Commit the version change
git add pyproject.toml
git commit -m "Bump version: $current_version → $new_version"

# Build the package
poetry build

# Upload the package to PyPI using twine
twine upload dist/*

# Create a Git tag for the new version
git tag -a "v$new_version" -m "Version $new_version"

# Push the changes and tags to the repository
git push origin main
git push --tags
