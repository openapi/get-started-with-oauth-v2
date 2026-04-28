#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret

printf 'Creating token...\n'

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X POST "$BASE/tokens" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "my-first-token",
    "scopes": ["GET:company.openapi.it/IT-start"],
    "ttl": 2592000
  }' | $JQ
