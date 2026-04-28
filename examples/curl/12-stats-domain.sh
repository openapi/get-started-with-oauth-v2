#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret
ask DOMAIN        "API domain (e.g. company.openapi.com)"

printf 'Date filter (YYYY | YYYY-MM | YYYY-MM-DD), leave blank for all time: '
read -r DATE

if [ -n "$DATE" ]; then
  URL="$BASE/stats/apis/$DOMAIN?date=$DATE"
else
  URL="$BASE/stats/apis/$DOMAIN"
fi

printf 'Getting stats for domain %s...\n' "$DOMAIN"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" "$URL" | $JQ
