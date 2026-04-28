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

read -rp "How many transactions to return? [default: 20] " LIMIT
LIMIT="${LIMIT:-20}"

read -rp "Skip (for pagination)? [default: 0] " SKIP
SKIP="${SKIP:-0}"

echo "Getting wallet transactions (limit=$LIMIT, skip=$SKIP)..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/wallet/transactions?limit=$LIMIT&skip=$SKIP" | $JQ
