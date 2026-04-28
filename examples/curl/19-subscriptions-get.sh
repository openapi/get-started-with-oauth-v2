#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL   "Email"
ask OPENAPI_KEY     "API key" secret
ask SUBSCRIPTION_ID "Subscription ID"

printf 'Getting subscription %s...\n' "$SUBSCRIPTION_ID"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "$BASE/subscriptions/$SUBSCRIPTION_ID" | $JQ
