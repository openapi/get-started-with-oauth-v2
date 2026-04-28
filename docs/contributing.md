# Contributing

Thanks for considering contributing to **get-started-with-oauth-v2**! This repo is a collection of ready-to-run examples for the Openapi OAuth V2 API. Every language, tool, or improvement is welcome.

## What you can contribute

- **New language examples** — add a folder under `examples/` (e.g. `examples/python`, `examples/node`)
- **Improvements to existing examples** — clearer snippets, better variable names, more edge cases covered
- **Documentation fixes** — typos, broken links, outdated info

## How to contribute

1. Fork the repository and clone it locally:

   ```bash
   git clone https://github.com/openapi/get-started-with-oauth-v2.git
   ```

2. Create a branch for your addition:

   ```bash
   git checkout -b examples/python
   ```

3. Add your examples. Each language folder should include:
   - A `README.md` explaining prerequisites and how to run the snippets
   - Self-contained scripts with clear variable placeholders (`YOUR_EMAIL`, `YOUR_API_KEY`, etc.)
   - No hardcoded credentials

4. Commit and push:

   ```bash
   git commit -m "Add Python examples"
   git push origin examples/python
   ```

5. Open a Pull Request describing what you added and how you tested it.

## Guidelines

- Use the **production** base URL `https://oauth.openapi.com` in examples; mention the **sandbox** (`https://test.oauth.openapi.com`) for free testing.
- Keep snippets focused — one file per logical group of endpoints (tokens, stats, wallet, …).
- Do not commit real credentials.

## Reporting issues

Open a GitHub issue including a clear description and, if applicable, the exact request/response that shows the problem.
