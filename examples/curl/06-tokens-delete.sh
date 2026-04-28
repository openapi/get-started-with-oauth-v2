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
ask TOKEN_ID      "Token ID to delete"

BASE="${OPENAPI_BASE_URL:-https://oauth.openapi.com}"
JQ=$(command -v jq || echo cat)

read -rp "Delete token '$TOKEN_ID'? This cannot be undone. [y/N] " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }

echo "Deleting token $TOKEN_ID..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X DELETE "$BASE/tokens/$TOKEN_ID" | $JQ
