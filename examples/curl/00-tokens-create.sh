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

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret

BASE="${OPENAPI_BASE_URL:-https://oauth.openapi.com}"
JQ=$(command -v jq || echo cat)

echo "Creating token..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X POST "$BASE/tokens" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "my-first-token",
    "scopes": ["GET:company.openapi.com/IT-start"],
    "ttl": 2592000
  }' | $JQ
