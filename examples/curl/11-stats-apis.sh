#!/bin/sh
set -eu
. "$(dirname "$0")/99-openapi.sh"

ask OPENAPI_EMAIL "Email"
ask OPENAPI_KEY   "API key" secret

printf 'Date filter (YYYY | YYYY-MM | YYYY-MM-DD), leave blank for all time: '
read -r DATE

if [ -n "$DATE" ]; then
  URL="$BASE/stats/apis?date=$DATE"
else
  URL="$BASE/stats/apis"
fi

printf 'Getting stats grouped by API domain...\n'

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" "$URL" | $JQ
