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
ask TOKEN_ID      "Token ID to update"

BASE="${OPENAPI_BASE_URL:-https://oauth.openapi.com}"
JQ=$(command -v jq || echo cat)

echo "Updating token $TOKEN_ID..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X PATCH "$BASE/tokens/$TOKEN_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "updated-token",
    "ttl": 604800,
    "scopes": ["GET:company.openapi.com/IT-start", "GET:company.openapi.com/IT-advanced"]
  }' | $JQ
