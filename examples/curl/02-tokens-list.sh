#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret

printf 'Listing tokens...\n'

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/tokens" | $JQ
