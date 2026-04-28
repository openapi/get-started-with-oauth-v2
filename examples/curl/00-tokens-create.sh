#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret

echo "Creating token..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X POST "$BASE/tokens" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "my-first-token",
    "scopes": ["GET:company.openapi.com/IT-start"],
    "ttl": 2592000
  }' | $JQ
