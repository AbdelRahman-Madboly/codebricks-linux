# Starting a New Repo or Project

A decision guide for the moment *before* `git init`. This is the "should I, and what shape?"
companion to [`oss-and-licensing.md`](oss-and-licensing.md), which has the full file-by-file setup
checklist and the licence decision tree.

---

## 1. First decision: new project, or contribute to an existing one?

Don't start a new repo by default. Ask:

```
Does something already solve this (or 80% of it)?
  ├─ Yes, and it's maintained        → contribute / extend it (open an issue first)
  ├─ Yes, but abandoned / wrong fit  → fork it, or start fresh if the fork would be a rewrite
  └─ No                              → start a new project
```

**Why.** A new repo is a long-term maintenance commitment (issues, releases, docs, security). Reusing
or contributing is almost always cheaper and gets your change in front of real users faster. Start
something new only when the need is real and unmet.

## 2. Is this even a separate project, or part of an existing one?

Start a **new repository** (not just a new folder) when the thing:

- has its own **release cycle / version** independent of your other code,
- has a **different audience or licence**,
- would be **depended on** by more than one other project, or
- has a clearly **different scope** (mixing scopes is a top cause of project failure).

Keep it **inside an existing repo** when it's a feature, a script, or a module that only ever ships
together with that repo. Splitting too early creates coordination overhead; splitting too late
creates a tangled monorepo. Split when the boundaries above actually appear.

## 3. Public or private?

| Choose **public** when | Choose **private** when |
|------------------------|-------------------------|
| It's open source / a portfolio piece | It contains proprietary or client code |
| You want outside contributions | It holds secrets, keys, or unreleased work |
| The work itself is the demonstration | You're not ready to commit to a licence yet |

> You can start private and flip to public later — but scrub history for secrets first; making a
> repo public exposes **every past commit**, not just the current files.

## 4. Day-zero decisions (cheap now, expensive later)

Lock these before the first outside contribution:

| Decision | Why it's hard to change later |
|----------|-------------------------------|
| **Licence** | Relicensing needs sign-off from every contributor who holds rights — [see the licence section](oss-and-licensing.md#1-choosing-a-licence) |
| **Name** | Renaming breaks links, package names, and muscle memory; check it's not a taken trademark/package name |
| **Scope statement** | A one-line "what this is and isn't" in the README prevents scope creep |
| **Default branch + commit style** | Conventions are painful to retrofit across history |

## 5. Minimal file set to be "contributable"

A repo strangers can actually use and contribute to has, at minimum:

- `README.md` — what it does, how to install/run, how to contribute, the licence.
- `LICENSE` — the **full licence text** (not just a name).
- `.gitignore` — language-appropriate.
- `CONTRIBUTING.md` — the workflow you expect (branching, tests, PR norms).

Add as the project grows: `CODE_OF_CONDUCT.md`, `CHANGELOG.md`, issue/PR templates, CI config.
The full checklist with rationale is in [`oss-and-licensing.md` §2](oss-and-licensing.md#2-starting-a-new-oss-project--checklist).

## 6. Versioning from the start

Use **Semantic Versioning** (`MAJOR.MINOR.PATCH`) so consumers know what an update means:

- `PATCH` — backwards-compatible bug fix
- `MINOR` — backwards-compatible new feature
- `MAJOR` — breaking change

Start at `0.1.0` while the API is still moving; release `1.0.0` when you're willing to promise
stability.

---

## Quick checklist

- [ ] Confirmed nothing existing should be reused/contributed to instead
- [ ] Decided new repo vs part of an existing one (scope, release cycle, dependents)
- [ ] Chose public vs private (and scrubbed secrets if it'll be public)
- [ ] Picked and committed a **licence** before outside contributions
- [ ] Chose a name that isn't already taken
- [ ] Wrote a one-line scope statement
- [ ] Added `README`, `LICENSE`, `.gitignore`, `CONTRIBUTING.md`
- [ ] Set a starting version (`0.1.0`)
