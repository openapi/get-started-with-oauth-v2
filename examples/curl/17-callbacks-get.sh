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
ask CALLBACK_ID   "Callback ID"

BASE="${OPENAPI_BASE_URL:-https://oauth.openapi.com}"
JQ=$(command -v jq || echo cat)

echo "Getting callback $CALLBACK_ID..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/callbacks/$CALLBACK_ID" | $JQ
