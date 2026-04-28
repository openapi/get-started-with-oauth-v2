# cURL examples

Ready-to-run shell scripts for every endpoint of the Openapi OAuth V2 API.
Each script prompts for credentials interactively if the environment variables are not set.
All scripts are POSIX-compatible and work with `sh`, `bash`, and `zsh`.

## Prerequisites

- `curl`
- `jq` _(optional — output is pretty-printed if available, raw JSON otherwise)_

## Run an example

```bash
git clone https://github.com/openapi/get-started-with-oauth-v2.git
cd get-started-with-oauth-v2/examples/curl
sh 00-tokens-create.sh
```

You can export your credentials once to skip the prompts across all scripts:

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

Use this as the first step of any integration: generate a token scoped to only the APIs your app needs. Useful for CI/CD pipelines, backend services, or handing a limited key to a third party.

```bash
sh 00-tokens-create.sh
```

[View source →](00-tokens-create.sh)

### 01 — Create a token with limits

Create a token that caps total requests, wallet spend, and restricts usage to specific IPs. Ideal for partner integrations, sandboxed environments, or pay-per-use services where you want hard cost controls.

```bash
sh 01-tokens-create-limits.sh
```

[View source →](01-tokens-create-limits.sh)

### 02 — List tokens

Audit all active tokens on your account — useful during security reviews, before revoking stale keys, or to check which services are still active.

```bash
sh 02-tokens-list.sh
```

[View source →](02-tokens-list.sh)

### 03 — Get token by ID

Inspect a specific token's scopes, limits, stats, and expiry. Handy when debugging an integration or verifying that limits were applied correctly after creation.

```bash
sh 03-tokens-get.sh
```

[View source →](03-tokens-get.sh)

### 04 — Update a token

Add or remove scopes, extend the TTL, or tighten limits on an existing token — without deleting and recreating it. Useful when requirements change mid-project or you need to grant access to a new API.

```bash
sh 04-tokens-update.sh
```

[View source →](04-tokens-update.sh)

### 05 — Rotate a token (refresh-token flow)

Exchange the refresh token for a brand-new access token and refresh token pair, while preserving all scopes and accumulated stats. Use this for zero-downtime key rotation in production services.

```bash
sh 05-tokens-rotate.sh
```

[View source →](05-tokens-rotate.sh)

### 06 — Delete a token

Permanently revoke a token. Use this to clean up unused keys, respond to a potential credential leak, or decommission an integration.

```bash
sh 06-tokens-delete.sh
```

[View source →](06-tokens-delete.sh)

---

## Scopes

### 07 — List available scopes

Discover all the API endpoints your account has access to, along with their identifiers. Use this before creating a token to know exactly which scope strings to include.

```bash
sh 07-scopes-list.sh
```

[View source →](07-scopes-list.sh)

### 08 — Get scope by ID

Inspect rate limits, free quotas, pricing, and requirements for a specific scope before enabling it on a token. Useful when estimating costs or checking if a scope needs additional account setup.

```bash
sh 08-scopes-get.sh
```

[View source →](08-scopes-get.sh)

---

## Stats

### 09 — Overall usage stats

Get a snapshot of total requests, paid calls, errors, unique IPs, and wallet spend across all APIs. Useful for monthly reporting, cost forecasting, or spotting unexpected usage spikes.

```bash
sh 09-stats-overview.sh
```

[View source →](09-stats-overview.sh)

### 10 — Unique IP list

Retrieve all IP addresses that made requests under your account in a given period. Useful for detecting unexpected callers, auditing access patterns, or building an IP allowlist.

```bash
sh 10-stats-ips.sh
```

[View source →](10-stats-ips.sh)

### 11 — Stats grouped by API domain

See how usage is distributed across all the API domains you consume — total calls, paid calls, errors, and spend per domain. Useful for understanding which integrations drive the most traffic or cost.

```bash
sh 11-stats-apis.sh
```

[View source →](11-stats-apis.sh)

### 12 — Stats for a specific domain

Drill into a single API domain to get per-scope breakdowns, IP lists, and granular metrics. Useful for debugging a specific integration or preparing a domain-level cost report.

```bash
sh 12-stats-domain.sh
```

[View source →](12-stats-domain.sh)

---

## Wallet

### 13 — Wallet balance

Check the current credit available on your account. Use this before running batch jobs or launching a new integration to make sure you have sufficient funds.

```bash
sh 13-wallet-balance.sh
```

[View source →](13-wallet-balance.sh)

### 14 — Wallet transactions

Browse the paginated history of credits and charges on your wallet. Useful for reconciling invoices, tracking spend over time, or identifying unexpected deductions.

```bash
sh 14-wallet-transactions.sh
```

[View source →](14-wallet-transactions.sh)

---

## Monitoring

### 15 — Error logs

List recent API errors with scope, HTTP status, error code, and the originating IP. Use this to diagnose integration failures, spot misconfigured tokens, or investigate 4xx spikes.

```bash
sh 15-errors-list.sh
```

[View source →](15-errors-list.sh)

### 16 — List callbacks

View recent callback deliveries for async APIs — including destination URL, HTTP response code, and completion status. Useful for verifying that webhooks are reaching your endpoint.

```bash
sh 16-callbacks-list.sh
```

[View source →](16-callbacks-list.sh)

### 17 — Get callback by ID

Inspect a single callback in detail: payload, headers, elapsed time, attempt count, and retry history. Use this to debug a failed or slow callback delivery.

```bash
sh 17-callbacks-get.sh
```

[View source →](17-callbacks-get.sh)

### 18 — List subscriptions

View active subscriptions on your account, including available requests, expiry dates, and auto-renew status. Useful for checking quota before a high-volume job or managing renewals.

```bash
sh 18-subscriptions-list.sh
```

[View source →](18-subscriptions-list.sh)

### 19 — Get subscription by ID

Inspect a specific subscription's full detail: pricing, remaining requests, type, and timeline. Useful when evaluating whether to renew, upgrade, or switch to wallet-based billing.

```bash
sh 19-subscriptions-get.sh
```

[View source →](19-subscriptions-get.sh)
