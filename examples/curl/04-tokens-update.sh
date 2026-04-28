#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret
ask TOKEN_ID      "Token ID to update"

printf 'Updating token %s...\n' "$TOKEN_ID"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X PATCH "$BASE/tokens/$TOKEN_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "updated-token",
    "ttl": 604800,
    "scopes": ["GET:company.openapi.com/IT-start", "GET:company.openapi.com/IT-advanced"]
  }' | $JQ
