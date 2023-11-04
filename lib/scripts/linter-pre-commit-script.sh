#!/bin/sh
# This file is `.git/hooks/format-ruby` and it has been `chmod +x`'d
# Assumption: https://github.com/testdouble/standard is in your Gemfile

set -eo

echo "Running standardrb 🚓 💨 💨 💨"

rubyfiles=$(git diff --name-only --diff-filter=ACM "*.rb" "*.rake" "Gemfile" "Rakefile" | tr '\n' ' ')
[ -z "$rubyfiles" ] && exit 0

# Standardize all ruby files
echo "💅 Formatting staged Ruby files using standardrb ($(echo $rubyfiles | wc -w | awk '{print $1}') total)"
echo "$rubyfiles" | xargs bundle exec standardrb --fix

# Add back the modified/prettified files to staging
# echo "$rubyfiles" | xargs git add

exit 0