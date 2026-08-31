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

# Two columns rather than one. This turns on line numbers implicitly, and long
# lines wrap instead of being cut off.
git config --global delta.side-by-side true

# Line numbers on unchanged lines default to #444444, which is 2.2:1 against a
# dark terminal and not really readable. #767676 clears 4.5:1 while staying
# dimmer than the code itself, so the numbers still recede.
git config --global delta.line-numbers-zero-style "#767676"

# Contrast. The default Monokai comment colour (#75715e) lands at 3.3:1 against
# delta's added-line background and 1.6:1 inside an emphasised span, well under
# the 4.5:1 needed to read body text. zenburn's comment colour is light enough
# to survive both. Measured over a sample of real commits, that alone takes the
# share of under-contrast text from 17.6% to 0.4%; darkening the two emphasis
# backgrounds takes it to 0.1%.
git config --global delta.syntax-theme zenburn
git config --global delta.plus-emph-style "syntax #00401a"
git config --global delta.minus-emph-style "syntax #5c0710"

# delta brings its own palette. Drop the diff-so-fancy colors, which would
# otherwise still reach `git add -p`, because `delta --color-only` passes
# git's own colors through untouched.
git config --global --remove-section color.diff-highlight > /dev/null 2>&1 || true
git config --global --remove-section color.diff > /dev/null 2>&1 || true

echo "git pager: delta"
