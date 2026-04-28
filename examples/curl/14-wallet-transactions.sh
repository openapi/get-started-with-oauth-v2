#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret

printf 'How many transactions to return? [default: 20] '
read -r LIMIT
LIMIT="${LIMIT:-20}"

printf 'Skip (for pagination)? [default: 0] '
read -r SKIP
SKIP="${SKIP:-0}"

printf 'Getting wallet transactions (limit=%s, skip=%s)...\n' "$LIMIT" "$SKIP"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/wallet/transactions?limit=$LIMIT&skip=$SKIP" | $JQ
