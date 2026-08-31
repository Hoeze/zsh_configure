#!/bin/sh
#
# Point git at git-delta for paging and diff highlighting.
#
# Counterpart: diff-so-fancy_configure.sh. The two set incompatible palettes,
# so run one or the other, never both. zsh_configure.sh calls this one.

if ! command -v delta > /dev/null 2>&1; then
    echo "delta not found in PATH." >&2
    echo "Install it from https://github.com/dandavison/delta, or run" >&2
    echo "diff-so-fancy_configure.sh instead." >&2
    exit 1
fi

git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global delta.dark true

# delta brings its own palette. Drop the diff-so-fancy colors, which would
# otherwise still reach `git add -p`, because `delta --color-only` passes
# git's own colors through untouched.
git config --global --remove-section color.diff-highlight > /dev/null 2>&1 || true
git config --global --remove-section color.diff > /dev/null 2>&1 || true

echo "git pager: delta"
