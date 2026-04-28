# cURL examples

Ready-to-run shell scripts for every endpoint of the Openapi OAuth V2 API.
Each script prompts for credentials interactively if the environment variables are not set.

## Prerequisites

- `curl`
- `jq` _(optional — output is pretty-printed if available, raw JSON otherwise)_

## Run an example

```bash
git clone https://github.com/openapi/get-started-with-oauth-v2.git
cd get-started-with-oauth-v2/examples/curl
bash 00-tokens-create.sh
```

You can also export your credentials once to skip the prompts across all scripts:

```bash
export OPENAPI_EMAIL="your@email.com"
export OPENAPI_KEY="your-api-key"
```

To target the **Sandbox** instead of production (free, no charges):

```bash
export OPENAPI_BASE_URL="https://test.oauth.openapi.com"
```

---

## Tokens

### 00 — Create a token

```bash
bash 00-tokens-create.sh
```

[View source →](00-tokens-create.sh)

### 01 — Create a token with limits

```bash
bash 01-tokens-create-limits.sh
```

[View source →](01-tokens-create-limits.sh)

### 02 — List tokens

```bash
bash 02-tokens-list.sh
```

[View source →](02-tokens-list.sh)

### 03 — Get token by ID

```bash
bash 03-tokens-get.sh
```

[View source →](03-tokens-get.sh)

### 04 — Update a token

```bash
bash 04-tokens-update.sh
```

[View source →](04-tokens-update.sh)

### 05 — Rotate a token (refresh-token flow)

```bash
bash 05-tokens-rotate.sh
```

[View source →](05-tokens-rotate.sh)

### 06 — Delete a token

```bash
bash 06-tokens-delete.sh
```

[View source →](06-tokens-delete.sh)

---

## Scopes

### 07 — List available scopes

```bash
bash 07-scopes-list.sh
```

[View source →](07-scopes-list.sh)

### 08 — Get scope by ID

```bash
bash 08-scopes-get.sh
```

[View source →](08-scopes-get.sh)

---

## Stats

### 09 — Overall usage stats

```bash
bash 09-stats-overview.sh
```

[View source →](09-stats-overview.sh)

### 10 — Unique IP list

```bash
bash 10-stats-ips.sh
```

[View source →](10-stats-ips.sh)

### 11 — Stats grouped by API domain

```bash
bash 11-stats-apis.sh
```

[View source →](11-stats-apis.sh)

### 12 — Stats for a specific domain

```bash
bash 12-stats-domain.sh
```

[View source →](12-stats-domain.sh)

---

## Wallet

### 13 — Wallet balance

```bash
bash 13-wallet-balance.sh
```

[View source →](13-wallet-balance.sh)

### 14 — Wallet transactions

```bash
bash 14-wallet-transactions.sh
```

[View source →](14-wallet-transactions.sh)

---

## Monitoring

### 15 — Error logs

```bash
bash 15-errors-list.sh
```

[View source →](15-errors-list.sh)

### 16 — List callbacks

```bash
bash 16-callbacks-list.sh
```

[View source →](16-callbacks-list.sh)

### 17 — Get callback by ID

```bash
bash 17-callbacks-get.sh
```

[View source →](17-callbacks-get.sh)

### 18 — List subscriptions

```bash
bash 18-subscriptions-list.sh
```

[View source →](18-subscriptions-list.sh)

### 19 — Get subscription by ID

```bash
bash 19-subscriptions-get.sh
```

[View source →](19-subscriptions-get.sh)
