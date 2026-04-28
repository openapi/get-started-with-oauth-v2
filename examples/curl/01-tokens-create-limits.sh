#!/usr/bin/env bash
set -euo pipefail

ask() {
  local var="$1" prompt="$2" secret="${3:-}"
  [[ -n "${!var:-}" ]] && return
  if [[ -n "$secret" ]]; then
    read -rsp "$prompt: " "$var"; echo
  else
    read -rp  "$prompt: " "$var"
  fi
}

ask OPENAPI_EMAIL   "Email"
ask OPENAPI_KEY     "API key" secret
ask ALLOWED_IP      "Allowed IP for this token (e.g. 203.0.113.10)"

BASE="${OPENAPI_BASE_URL:-https://oauth.openapi.com}"
JQ=$(command -v jq || echo cat)

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
