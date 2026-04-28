#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret
ask TOKEN_ID      "Token ID to delete"

printf "Delete token '%s'? This cannot be undone. [y/N] " "$TOKEN_ID"
read -r confirm
case "$confirm" in
  [Yy]) ;;
  *) printf 'Aborted.\n'; exit 0 ;;
esac

printf 'Deleting token %s...\n' "$TOKEN_ID"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X DELETE "$BASE/tokens/$TOKEN_ID" | $JQ
