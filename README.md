> [!NOTE]
> **OAuth V2 is now live.** Granular token limits, refresh-token rotation, wallet transactions, advanced stats, and full monitoring — all in one API.
> [Read the docs →](https://openapi.it/en/docs/oauth)

---

# Get Started with OAuth V2

A curated collection of code examples showing how to use the **Openapi OAuth V2 API** — from creating your first token to inspecting usage stats across every language you work in.

## What is OAuth V2?

OAuth V2 is the new Openapi token management layer. Compared to V1 it adds:

- **Granular token limits** — cap total requests, paid requests, wallet spend and allowed IPs per token
- **Refresh-token rotation** — extend a token's TTL securely via `PATCH` without losing accumulated stats
- **Wallet transactions** — paginated history of every credit and expense on your account
- **Advanced stats** — aggregate metrics, unique IP lists, and per-domain / per-scope breakdowns
- **Full monitoring** — inspect callback deliveries, active subscriptions and integration error logs

## Documentation

| Resource | Link |
|---|---|
| Getting started guide | [openapi.it/en/docs/oauth](https://openapi.it/en/docs/oauth) |
| API Reference (Swagger UI) | [oauth.openapi.com](https://oauth.openapi.com) |
| Sandbox environment | [test.oauth.openapi.com](https://test.oauth.openapi.com) |
| Postman collection | [openapi.it/en/docs/oauth#postman](https://openapi.it/en/docs/oauth#postman) |
| OAS3 specification | [openapi.it/en/docs/oauth#oas3](https://openapi.it/en/docs/oauth#oas3) |

## Examples

Each subfolder contains self-contained, runnable examples for a specific language or tool.

| Language / Tool | Folder |
|---|---|
| cURL | [`examples/curl`](examples/curl) |

## Authentication

All endpoints use **HTTP Basic Auth** — your account email as username and your API key as password.

```
Authorization: Basic base64(EMAIL:APIKEY)
```

The only exception is token refresh: pass the refresh token as a **Bearer** token when calling `PATCH /tokens/{token}`.

## Quick start

1. Generate a token from the [Openapi console](https://console.openapi.com/oauth) or via API.
2. Pick the examples folder for your language.
3. Copy the snippet, set your credentials, run it.

---

[openapi.it](https://openapi.it) · [Support](https://openapi.it/en/support) · [Terms](https://openapi.it/en/terms-and-conditions)