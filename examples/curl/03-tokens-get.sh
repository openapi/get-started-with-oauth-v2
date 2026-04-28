#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret
ask TOKEN_ID      "Token ID"

printf 'Getting token %s...\n' "$TOKEN_ID"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/tokens/$TOKEN_ID" | $JQ
