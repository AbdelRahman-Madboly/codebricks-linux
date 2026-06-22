# OSS Reference — Licences, Contribution & Project Setup

A practical cheat-sheet for starting or contributing to open source projects.

---

## 1. Choosing a Licence

### Decision tree

```
Does your project depend on GPL-licensed code?
  └─ Yes → You must use GPL (or a GPL-compatible licence)
  └─ No  → Do you want to allow proprietary use of your code?
            └─ Yes → Use MIT or Apache 2.0
            └─ No  → Use GPL v3 (forces all derivatives to stay open)
```

### Licence comparison table

| Licence | Family | Modify & keep closed? | Patent grant? | Viral? | Best for |
|---------|--------|-----------------------|---------------|--------|----------|
| **MIT** | Permissive | ✅ Yes | ❌ No | ❌ No | Maximum adoption, minimal friction |
| **Apache 2.0** | Permissive | ✅ Yes | ✅ Yes | ❌ No | Libraries, corporate-friendly OSS |
| **BSD 2-Clause** | Permissive | ✅ Yes | ❌ No | ❌ No | Academic / minimal overhead |
| **BSD 3-Clause** | Permissive | ✅ Yes | ❌ No | ❌ No | BSD 2 + no-endorsement clause |
| **GPL v2** | Copyleft | ❌ No | ❌ No | ✅ Yes | Linux kernel style; strong share-alike |
| **GPL v3** | Copyleft | ❌ No | ✅ Yes | ✅ Yes | GPL v2 + anti-tivoization + patent grant |
| **LGPL v3** | Weak copyleft | ⚠️ Linking ok | ✅ Yes | ⚠️ Partial | Libraries you want proprietary apps to link to |
| **MPL 2.0** | Weak copyleft | ⚠️ File-level | ✅ Yes | ⚠️ Partial | Per-file share-alike (Mozilla style) |
| **AGPL v3** | Network copyleft | ❌ No | ✅ Yes | ✅ Yes | SaaS; forces open source even for server-side use |

**Viral** = if you distribute software using this code, your software must use the same licence.

### When to pick what

- **Personal projects / libraries you want adopted widely** → MIT
- **You want patent protection for users** → Apache 2.0
- **You want everything derived to stay open** → GPL v3
- **You're writing a library but want apps to remain proprietary** → LGPL v3
- **You're building a web service and want all forks to stay open** → AGPL v3
- **You're contributing to an existing project** → match the project's existing licence

### What changes a licence is hard

Adding contributors means adding rights-holders. Relicensing later requires either:
- A Contributor Licence Agreement (CLA) that transfers rights to you upfront, or
- Contacting every contributor and getting written permission.

**Decide early. Write it in `LICENSE` before the first commit.**

---

## 2. Starting a New OSS Project — Checklist

### Repository setup

- [ ] `LICENSE` — exact text of your chosen licence (not just a name)
- [ ] `README.md` — what it does, how to install, how to contribute, licence badge
- [ ] `CONTRIBUTING.md` — how to submit issues and pull requests, code style, DCO/CLA if needed
- [ ] `CODE_OF_CONDUCT.md` — Contributor Covenant is the standard template
- [ ] `.gitignore` — language-appropriate defaults (use gitignore.io)
- [ ] `CHANGELOG.md` — keep a log of notable changes per version

### Governance decisions to make before going public

| Question | Options |
|----------|---------|
| Who can merge? | Only you (BDFL) / named maintainers / any contributor with review approval |
| How are decisions made? | Owner decides / consensus / vote |
| What happens if you stop maintaining it? | State it in README or create a CODEOWNERS file |
| Do contributors sign a CLA? | Yes (easier relicensing) / No (simpler onboarding) / DCO via commit sign-off |

### Versioning

Use **Semantic Versioning** (`MAJOR.MINOR.PATCH`):
- `PATCH` — backwards-compatible bug fix
- `MINOR` — new backwards-compatible feature
- `MAJOR` — breaking change

---

## 3. Contributing to an Existing OSS Project — Workflow

### Before writing any code

1. Read `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, and recent issues/PRs to understand norms.
2. Check if the issue you want to fix already has an open issue or PR — do not duplicate work.
3. Open an issue first for non-trivial changes; get buy-in before investing time.
4. Find the subsystem maintainer for the area you are touching.

### Submitting changes

```
fork → clone → create branch → small focused commits → push → open PR
```

- Keep PRs small and focused on one thing. Reviewers reject large monolithic diffs.
- Write a clear PR description: what, why, how to test.
- Respond to review comments promptly and without defensiveness.
- Do not disappear after opening a PR — orphaned PRs get closed.

### Commit messages (conventional commits)

```
<type>(<scope>): <short summary>

<body: what and why, not how>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`

Example:
```
fix(auth): reject tokens with expired signatures

JWT expiry was checked only on decode, not on refresh.
Added explicit exp check in the refresh handler.
```

---

## 4. Licence Compatibility Quick Reference

When combining code from multiple sources, licences must be compatible:

| Your project uses | Can you add code under… |
|-------------------|------------------------|
| MIT | ✅ MIT, Apache 2.0, BSD, GPL v2/v3 |
| Apache 2.0 | ✅ MIT, BSD — ⚠️ GPL v2 (incompatible) — ✅ GPL v3 |
| GPL v2 | ✅ GPL v2, LGPL v2 — ❌ Apache 2.0, GPL v3 |
| GPL v3 | ✅ GPL v2/v3, LGPL, Apache 2.0, MIT, BSD |
| AGPL v3 | ✅ GPL v3, MIT, BSD, Apache 2.0 |

**Golden rule:** GPL is sticky upward. If any dependency is GPL, your combined work must be GPL (or compatible).

---

## 5. Patents

- A **patent** gives exclusionary rights; a **copyright** prevents copying; a **trademark** protects a name/logo. They are separate and can coexist on the same work.
- Apache 2.0 and GPL v3 include an **explicit patent grant** — contributors cannot later sue users for using their patented contributions.
- MIT and BSD do **not** include a patent grant.
- If patent protection matters (commercial use, risk of litigation), prefer **Apache 2.0** over MIT.
- The **Open Invention Network (OIN)** is a mutual non-aggression patent pool for Linux-related technology. Membership is free for individuals/small companies and provides protection from 3,000+ member companies including Google, IBM, Microsoft, Red Hat.

---

## 6. What NOT to Do (Common Mistakes)

| Mistake | Consequence |
|---------|------------|
| No licence file | Code is **all rights reserved** by default — no one can legally use it |
| Copy-pasting code without checking its licence | You may be violating the upstream licence |
| Using GPL code in a closed proprietary product | Licence violation; you must open your source |
| Switching licence after many contributors exist | Requires consent from every contributor |
| Opening a large PR with no prior discussion | Will likely be rejected or ignored |
| Vanishing after opening a PR | PR will be closed as abandoned |

---

## 7. FUD to Ignore

Common myths about open source — all false:

- *"If I use any OSS, I must open all my code"* — Only GPL-licensed dependencies trigger this, and even then only in distributed products.
- *"OSS has no commercial support"* — Red Hat, Canonical, HashiCorp, Elastic, and hundreds of others provide paid support.
- *"OSS is insecure because anyone can see the source"* — The opposite is true: public code is audited by more people. Security-through-obscurity is not a real defence.
- *"OSS is free so it must be low quality"* — Linux, Git, PostgreSQL, Kubernetes, Firefox, Apache, Python. Enough said.

---

## 8. Resources

| Resource | What it's for |
|----------|--------------|
| [choosealicense.com](https://choosealicense.com) | Plain-English licence picker |
| [tldrlegal.com](https://tldrlegal.com) | Human-readable summaries of every licence |
| [spdx.org/licenses](https://spdx.org/licenses) | Canonical SPDX licence identifier list |
| [gitignore.io](https://gitignore.io) | Generate `.gitignore` for any stack |
| [contributor-covenant.org](https://www.contributor-covenant.org) | Standard `CODE_OF_CONDUCT.md` template |
| [conventionalcommits.org](https://www.conventionalcommits.org) | Conventional commit message spec |
| [semver.org](https://semver.org) | Semantic versioning spec |
| [openinventionnetwork.com](https://openinventionnetwork.com) | Join OIN for free patent protection |
