<div align="center">
  <a href="https://openapi.com/">
    <img alt="Openapi OAuth V2" src=".github/assets/images/repo-header-a4.png">
  </a>

  <h1>🚀 OAuth V2 is now live</h1>
  <p>Granular token limits · Refresh-token rotation · Wallet transactions · Advanced stats · Full monitoring</p>

[![API Version](https://img.shields.io/badge/OAuth_API-v2.1.0-4f46e5)](https://openapi.com/en/docs/oauth)
[![License](https://img.shields.io/github/license/openapi/get-started-with-oauth-v2)](LICENSE)
[![Sandbox](https://img.shields.io/badge/sandbox-free-22c55e)](https://test.oauth.openapi.com)
<br>
[![Linux Foundation Member](https://img.shields.io/badge/Linux%20Foundation-Silver%20Member-003778?logo=linux-foundation&logoColor=white)](https://www.linuxfoundation.org/about/members)
<br>

**[Read the docs →](https://openapi.com/en/docs/oauth)**

</div>

---

# 🔐 OAuth V2 — Get Started

> Code examples for the new <a href="https://openapi.com/en/docs/oauth">Openapi® OAuth V2 API</a> — tokens, stats, wallet, monitoring and more</h4>

---

A curated collection of code examples showing how to use the **Openapi OAuth V2 API** — from creating your first token to inspecting usage stats across every language you work in.

## What's new in V2?

- **Granular token limits** — cap total requests, paid requests, wallet spend and allowed IPs per token
- **Refresh-token rotation** — extend a token's TTL securely via `PATCH` without losing accumulated stats
- **Wallet transactions** — paginated history of every credit and expense on your account
- **Advanced stats** — aggregate metrics, unique IP lists, and per-domain / per-scope breakdowns
- **Full monitoring** — inspect callback deliveries, active subscriptions and integration error logs

## Documentation

| Resource | Link |
|---|---|
| Getting started guide | [openapi.com/en/docs/oauth](https://openapi.com/en/docs/oauth) |
| API Reference (Swagger UI) | [oauth.openapi.com](https://oauth.openapi.com) |
| Sandbox environment | [test.oauth.openapi.com](https://test.oauth.openapi.com) |
| Postman collection | [openapi.com/en/docs/oauth#postman](https://openapi.com/en/docs/oauth#postman) |
| OAS3 specification | [openapi.com/en/docs/oauth#oas3](https://openapi.com/en/docs/oauth#oas3) |

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

[openapi.com](https://openapi.com) · [Support](https://openapi.com/en/support) · [Terms](https://openapi.com/en/terms-and-conditions)



## Contributing

Contributions are always welcome! Whether you want to report bugs, suggest new features, improve documentation, or contribute code, your help is appreciated.

See [docs/contributing.md](docs/contributing.md) for detailed instructions on how to get started. Please make sure to follow this project's [docs/code-of-conduct.md](docs/code-of-conduct.md) to help maintain a welcoming and collaborative environment.

## Authors

Meet the project authors:

- L. Paderi ([@lpaderiAltravia](https://www.github.com/lpaderiAltravia))
- Openapi Team ([@openapi-it](https://github.com/openapi-it))

## Partners

Meet our partners using Openapi or contributing to this SDK:

- [Blank](https://www.blank.app/)
- [Credit Safe](https://www.creditsafe.com/)
- [Deliveroo](https://deliveroo.it/)
- [Gruppo MOL](https://molgroupitaly.it/it/)
- [Jakala](https://www.jakala.com/)
- [Octotelematics](https://www.octotelematics.com/)
- [OTOQI](https://otoqi.com/)
- [PWC](https://www.pwc.com/)
- [QOMODO S.R.L.](https://www.qomodo.me/)
- [SOUNDREEF S.P.A.](https://www.soundreef.com/)

## Our Commitments

We believe in open source and we act on that belief. We became Silver Members
of the Linux Foundation because we wanted to formally support the ecosystem
we build on every day. Open standards, open collaboration, and open governance
are part of how we work and how we think about software.

## License

This project is licensed under the [MIT License](LICENSE).

The MIT License is a permissive open-source license that allows you to freely use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the software, provided that the original copyright notice and this permission notice are included in all copies or substantial portions of the software.

In short, you are free to use this SDK in your personal, academic, or commercial projects, with minimal restrictions. The project is provided "as-is", without any warranty of any kind, either expressed or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement.

For more details, see the full license text at the [MIT License page](https://choosealicense.com/licenses/mit/).
