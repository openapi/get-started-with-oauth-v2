# OAuth V2 — cURL examples

Set your credentials once, then run any snippet below.

```bash
export OPENAPI_EMAIL="your@email.com"
export OPENAPI_KEY="your-api-key"
```

All examples target the **production** base URL `https://oauth.openapi.com`.
Swap it for `https://test.oauth.openapi.com` to use the Sandbox at no cost.

---

## Tokens

### Create a token

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X POST https://oauth.openapi.com/tokens \
  -H "Content-Type: application/json" \
  -d '{
    "name": "my-first-token",
    "scopes": ["GET:company.openapi.com/IT-start"],
    "ttl": 2592000
  }' | jq .
```

### Create a token with limits

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X POST https://oauth.openapi.com/tokens \
  -H "Content-Type: application/json" \
  -d '{
    "name": "limited-token",
    "scopes": ["GET:company.openapi.com/IT-start"],
    "ttl": 86400,
    "limits": {
      "totalRequests": 1000,
      "walletAmount": 5.00,
      "ip": ["203.0.113.10"]
    }
  }' | jq .
```

### List tokens

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/tokens | jq .
```

### Get a token by ID

```bash
TOKEN_ID="your-token-id"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/tokens/$TOKEN_ID | jq .
```

### Update a token (add scopes, extend TTL)

```bash
TOKEN_ID="your-token-id"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X PATCH https://oauth.openapi.com/tokens/$TOKEN_ID \
  -H "Content-Type: application/json" \
  -d '{
    "name": "updated-token",
    "ttl": 604800,
    "scopes": ["GET:company.openapi.com/IT-start", "GET:company.openapi.com/IT-advanced"]
  }' | jq .
```

### Rotate a token with refresh token

```bash
REFRESH_TOKEN="your-refresh-token"
TOKEN_ID="your-token-id"

curl -s \
  -X PATCH https://oauth.openapi.com/tokens/$TOKEN_ID \
  -H "Authorization: Bearer $REFRESH_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{}' | jq .
```

### Delete a token

```bash
TOKEN_ID="your-token-id"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  -X DELETE https://oauth.openapi.com/tokens/$TOKEN_ID | jq .
```

---

## Scopes

### List available scopes

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/scopes | jq .
```

### Get scope detail by ID

```bash
SCOPE_ID="your-scope-id"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/scopes/$SCOPE_ID | jq .
```

---

## Stats

### Overall usage stats

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/stats | jq .
```

### Stats filtered by date

```bash
# Accepts: YYYY  |  YYYY-MM  |  YYYY-MM-DD
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "https://oauth.openapi.com/stats?date=2026-04" | jq .
```

### List unique IP addresses

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "https://oauth.openapi.com/stats/ips?date=2026-04" | jq .
```

### Stats grouped by API domain

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/stats/apis | jq .
```

### Stats for a specific domain

```bash
DOMAIN="company.openapi.com"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "https://oauth.openapi.com/stats/apis/$DOMAIN" | jq .
```

---

## Wallet

### Get wallet balance

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/wallet | jq .
```

### List wallet transactions

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "https://oauth.openapi.com/wallet/transactions?limit=20&skip=0" | jq .
```

---

## Monitoring

### List error logs

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "https://oauth.openapi.com/errors?limit=10" | jq .
```

### List callbacks

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  "https://oauth.openapi.com/callbacks?limit=10" | jq .
```

### Get callback detail by ID

```bash
CALLBACK_ID="your-callback-id"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/callbacks/$CALLBACK_ID | jq .
```

### List subscriptions

```bash
curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/subscriptions | jq .
```

### Get subscription detail by ID

```bash
SUB_ID="your-subscription-id"

curl -s -u "$OPENAPI_EMAIL:$OPENAPI_KEY" \
  https://oauth.openapi.com/subscriptions/$SUB_ID | jq .
```
