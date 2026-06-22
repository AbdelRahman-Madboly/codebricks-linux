# Module 2 — Working in Open Source Projects

How to join a community and contribute without getting ignored, plus the engineering and legal
machinery around contributions: CI/CD, licences, and patents.

---

## 1. Before you write any code: investigate the project

**Concept.** A healthy contribution starts with *research*, not a patch. Every project has its own
scope, workflow, history, and communication norms — and breaking them gets your work rejected even
if the code is good.

**Why it works this way.** Maintainers are volunteers with limited time. A patch that ignores the
project's conventions creates work for them: it has to be re-explained, reformatted, or argued
about. Showing you've done your homework signals you'll be low-cost to work with.

**In practice — what to read first:**

- `README` — what the project is and how to build/run it.
- `CONTRIBUTING.md` — the required workflow (branching, tests, sign-off, style).
- `CODE_OF_CONDUCT.md` — behaviour expectations.
- Recent **issues and pull/merge requests** — the real culture: how people talk, what gets merged,
  what gets bounced.
- The **communication channels** — mailing list, chat, forum, issue tracker. Lurk before posting.

**Check for duplicate work** before starting: is there already an issue or open PR for this? If
it's non-trivial, **open an issue first** and get agreement on the approach before investing hours.

## 2. Contribution best practices

**Small, reviewable changes.** Submit incremental, digestible pieces — one logical change per
pull request. Reviewers cannot meaningfully review a huge "here's everything I did" diff, so large
dumps get rejected or ignored. Smaller PRs merge faster and build trust quicker.

**Communicate clearly.** A good PR description says **what** changed, **why**, and **how to test
it**. The commit body explains intent, not mechanics ("reject expired tokens on refresh" — not
"changed the if statement").

**Stay engaged.** Respond to review comments promptly and without defensiveness. Review is about
the code, not you. A PR that's opened and then abandoned gets closed — "vanishing after opening a
PR" is one of the most common ways contributions die.

**Work with maintainers, not around them.** Each area of a large project has a **maintainer** (and
big projects have **subsystem maintainers** for parts of the tree). They own review and acceptance
for their area. Find the right one, respect their call, and treat a "no" as information about the
project's direction rather than a personal rejection.

> **The mindset:** you are asking volunteers to take on the long-term cost of maintaining your
> change. Make that as easy and as low-risk as possible.

## 3. CI/CD — the automation that makes collaboration scale

When hundreds of strangers send changes, you cannot manually verify each one. CI/CD automates it.

| Stage | What it means | What it produces |
|-------|---------------|------------------|
| **CI — Continuous Integration** | Every commit/PR is automatically merged into a test branch, **built**, and **tested** | Fast pass/fail feedback; broken changes caught before merge |
| **CD — Continuous Delivery** | After tests pass, the software is automatically **packaged** and made ready to ship | A release artifact that *could* be deployed at any time |
| **CD — Continuous Deployment** | The passing, packaged build is automatically **released to end users** | Live updates with no manual release step |

**Why it works this way.** CI keeps the main branch always-working by refusing to merge anything
that breaks the build or tests — this is what lets many people contribute without the project
constantly falling over. Delivery and deployment remove slow, error-prone manual release steps.

**The relationship:** Integration → Delivery → Deployment is a pipeline of increasing automation.
You can do CI without auto-deploying; deployment builds on top of delivery, which builds on top of
integration.

**Benefits vs costs.**
- *Benefits:* bugs caught early and cheaply, always-shippable main branch, faster feedback,
  consistent repeatable releases, more confidence to change things.
- *Costs:* you must invest in a good test suite and pipeline; flaky tests erode trust;
  infrastructure has to be maintained.

**Common CI tooling (recognise the names):** general-purpose automation servers, hosted CI services
tied to a repo host, and the CI built into git-hosting platforms. The concept matters more than any
one tool — they all do "on every change: build, test, report."

> **Your own example to draw on:** a scheduled health-check that builds/calls a service on an
> interval and alerts on failure is the same *idea* as CI/monitoring — automated checks that catch
> breakage without a human watching.

## 4. Choosing a licence (the working version)

**Concept.** Picking a licence is choosing the rules others must follow to use your code. The big
fork is the same one from Module 1: **permissive** (let them do almost anything) vs **copyleft**
(force derivatives to stay open).

**Decide early.** This is the rule to remember: a licence change later requires permission from
**every contributor** who holds rights, because each contribution is owned by its author. The more
people who've contributed, the more impractical relicensing becomes. So write the `LICENSE` file
**before the first outside contribution**.

**Quick guidance:**
- Want the widest possible adoption / a library others embed → **permissive** (MIT, Apache 2.0).
- Want patent protection for your users → **Apache 2.0** (it has an explicit patent grant).
- Want every derivative to stay open → **copyleft** (GPL).
- Contributing to an existing project → **match its existing licence**, no debate.

Full decision tree, comparison, and compatibility rules:
[`oss-and-licensing.md`](../../reference/oss-and-licensing.md).

## 5. FUD — the misinformation to recognise

**FUD** = Fear, Uncertainty, Doubt: deliberate misinformation used to scare people away from open
source. Be able to refute the classics:

| Claim (false) | Reality |
|---------------|---------|
| "Using any OSS forces you to open *all* your code." | Only **copyleft** dependencies create obligations, and generally only when you **distribute**. Permissive licences impose no such thing. |
| "OSS has no support." | Large companies sell commercial support for open products; communities provide more. |
| "OSS is insecure because the source is public." | Public code is reviewed by more people; obscurity is not security. |
| "Free means low quality." | Much of the world's critical infrastructure is open source. |

The point isn't to memorise rebuttals — it's to recognise FUD as a *rhetorical tactic* and answer
it with specifics.

## 6. Patents, copyright, trademarks, and the patent pool

These are **three separate legal protections** that can all apply to the same software:

- **Copyright** — protects the *expression* (the actual code) from being copied. This is what
  software licences operate on.
- **Patent** — protects an *invention / method*. A patent holder can stop others from using the
  patented technique even if they wrote their own code from scratch.
- **Trademark** — protects a *name or logo* so users know who really made something.

**Why patents matter for OSS.** Copyright you handle with a licence. Patents are riskier: someone
could contribute code and *later* sue users over a patent the code relies on. To prevent that:

- **Apache 2.0 and GPL v3 include an explicit patent grant** — contributors promise not to sue
  users over patents covering their contribution. MIT and BSD do **not**.
- The **Open Invention Network (OIN)** is a mutual non-aggression **patent pool** for Linux-related
  technology: thousands of member companies (large and small) agree not to assert patents against
  each other's use of the covered open technology. Membership is free, which lets even individuals
  and small companies gain protection from the pool.

**In practice.** If patent risk matters (commercial use, litigious space), prefer a licence with a
patent grant (Apache 2.0) over one without (MIT).

---

## Check yourself

- List four things to read/check before contributing to a project. Why open an issue first?
- Why are small PRs preferred? Name two ways contributions commonly die.
- Define CI, Continuous Delivery, and Continuous Deployment, and explain how they stack.
- Give two benefits and one cost of adopting CI/CD.
- Why must a licence be chosen early? What's required to change it later?
- Refute three pieces of OSS FUD with specifics.
- Distinguish copyright, patent, and trademark. What does an Apache 2.0 patent grant do, and what
  is the OIN?
