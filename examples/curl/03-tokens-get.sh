#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret
ask TOKEN_ID      "Token ID"

echo "Getting token $TOKEN_ID..."

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/tokens/$TOKEN_ID" | $JQ
