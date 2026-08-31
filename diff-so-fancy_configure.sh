#!/bin/sh
#
# Point git at diff-so-fancy for paging and diff highlighting.
#
# Counterpart: delta_configure.sh, which zsh_configure.sh calls by default.
# Run this one by hand on hosts where delta is not available. The two set
# incompatible palettes, so run one or the other, never both.

if ! command -v diff-so-fancy > /dev/null 2>&1; then
    echo "diff-so-fancy not found in PATH." >&2
    echo "It ships with this repo as home/.local/bin/diff-so-fancy," >&2
    echo "so check that ~/.local/bin is on your PATH." >&2
    exit 1
fi

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# improved git colors from diff-so-fancy

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

# Clear delta's setup, so a host that switches back does not keep both.
git config --global --unset interactive.diffFilter > /dev/null 2>&1 || true
git config --global --remove-section delta > /dev/null 2>&1 || true

echo "git pager: diff-so-fancy"
