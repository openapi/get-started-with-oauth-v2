#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret
ask ALLOWED_IP    "Allowed IP for this token (e.g. 203.0.113.10)"

echo "Creating token with limits..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X POST "$BASE/tokens" \
  -H "Content-Type: application/json" \
  -d "{
    \"name\": \"limited-token\",
    \"scopes\": [\"GET:company.openapi.com/IT-start\"],
    \"ttl\": 86400,
    \"limits\": {
      \"totalRequests\": 1000,
      \"walletAmount\": 5.00,
      \"ip\": [\"$ALLOWED_IP\"]
    }
  }" | $JQ
