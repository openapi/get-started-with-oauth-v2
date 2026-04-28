#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret
ask SCOPE_ID      "Scope ID"

printf 'Getting scope %s...\n' "$SCOPE_ID"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/scopes/$SCOPE_ID" | $JQ
