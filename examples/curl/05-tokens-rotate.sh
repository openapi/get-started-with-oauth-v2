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

ask TOKEN_ID      "Token ID to rotate"
ask REFRESH_TOKEN "Refresh token" secret

BASE="${OPENAPI_BASE_URL:-https://oauth.openapi.com}"
JQ=$(command -v jq || echo cat)

echo "Rotating token $TOKEN_ID (refresh-token flow)..."
echo "The old token will be deleted and a new one returned."

curl -s \
  -X PATCH "$BASE/tokens/$TOKEN_ID" \
  -H "Authorization: Bearer $REFRESH_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{}' | $JQ
