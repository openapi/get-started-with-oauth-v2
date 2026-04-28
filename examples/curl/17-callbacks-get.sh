#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret
ask CALLBACK_ID   "Callback ID"

printf 'Getting callback %s...\n' "$CALLBACK_ID"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/callbacks/$CALLBACK_ID" | $JQ
