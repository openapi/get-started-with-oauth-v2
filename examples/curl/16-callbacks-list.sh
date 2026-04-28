#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret

printf 'How many callbacks to return? [default: 10] '
read -r LIMIT
LIMIT="${LIMIT:-10}"

printf 'Skip (for pagination)? [default: 0] '
read -r SKIP
SKIP="${SKIP:-0}"

printf 'Filter by scopes (comma-separated, leave blank for all): '
read -r SCOPES

URL="$BASE/callbacks?limit=$LIMIT&skip=$SKIP"
[ -n "$SCOPES" ] && URL="$URL&scopes=$SCOPES"

printf 'Getting callbacks...\n'

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" "$URL" | $JQ
