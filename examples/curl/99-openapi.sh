#!/bin/sh
# Shared helpers — dot-source this file, do not run it directly.
# Usage: . "$(dirname "$0")/99-openapi.sh"

ask() {
  _var="$1"
  _prompt="$2"
  _secret="${3:-}"
  eval "_val=\${$_var:-}"
  [ -n "$_val" ] && return
  if [ -n "$_secret" ]; then
    printf '%s: ' "$_prompt"
    stty -echo 2>/dev/null
    read -r _val
    stty echo 2>/dev/null
    printf '\n'
  else
    printf '%s: ' "$_prompt"
    read -r _val
  fi
  eval "$_var=\$_val"
}

BASE="${OPENAPI_BASE_URL:-https://oauth.openapi.com}"
JQ=$(command -v jq 2>/dev/null || echo cat)
