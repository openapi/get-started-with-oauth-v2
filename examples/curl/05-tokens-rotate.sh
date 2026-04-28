#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask TOKEN_ID      "Token ID to rotate"
ask REFRESH_TOKEN "Refresh token" secret

printf 'Rotating token %s (refresh-token flow)...\n' "$TOKEN_ID"
printf 'The old token will be deleted and a new one returned.\n'

curl -s \
  -X PATCH "$BASE/tokens/$TOKEN_ID" \
  -H "Authorization: Bearer $REFRESH_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{}' | $JQ
