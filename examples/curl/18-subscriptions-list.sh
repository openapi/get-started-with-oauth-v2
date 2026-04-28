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

read -rp "How many subscriptions to return? [default: 10] " LIMIT
LIMIT="${LIMIT:-10}"

read -rp "Skip (for pagination)? [default: 0] " SKIP
SKIP="${SKIP:-0}"

read -rp "Filter by scopes (comma-separated, leave blank for all): " SCOPES

URL="$BASE/subscriptions?limit=$LIMIT&skip=$SKIP"
[[ -n "$SCOPES" ]] && URL="$URL&scopes=$SCOPES"

echo "Getting subscriptions..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" "$URL" | $JQ
