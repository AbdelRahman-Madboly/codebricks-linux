# Interview Drills — Open Source Methods

Self-test. Cover the answer, say yours out loud, then check. These are generic — phrase them around
your own real projects when you answer in a room.

---

## Rapid-fire definitions

> Say each in one or two sentences.

1. **Open source software** — source available under a licence allowing inspection, modification,
   and redistribution. "Open" = those rights, not price.
2. **Permissive licence** — lets others modify and even keep changes closed (MIT, BSD, Apache 2.0).
3. **Copyleft licence** — derivatives must be released under the same open licence (GPL). "Sticky
   upward": GPL anywhere usually makes the whole work GPL.
4. **BDFL** — Benevolent Dictator For Life: one trusted founder has final say; works only with
   listening and mentoring.
5. **CI** — every change is auto-merged, built, and tested.
6. **Continuous Delivery** — passing builds are auto-packaged and kept ready to ship.
7. **Continuous Deployment** — passing builds are auto-released to users.
8. **FUD** — Fear, Uncertainty, Doubt: deliberate misinformation against OSS.
9. **OIN** — Open Invention Network: a free, mutual non-aggression patent pool for Linux-related tech.
10. **Maintainer** — trusted contributor who reviews and accepts patches for a project area.

## Short-answer scenarios

**Q. A teammate says "we can't use that library, it's open source — we'd have to publish our whole
codebase." Are they right?**
Usually no. Only **copyleft** (e.g. GPL) dependencies create source-release obligations, and
generally only when you **distribute** the software. A **permissive** (MIT/Apache/BSD) dependency
imposes no such requirement. Check the actual licence before deciding.

**Q. You want to fix a bug in a project you've never touched. Walk me through the first hour.**
Read `README` and `CONTRIBUTING.md`; skim recent issues/PRs for norms and to avoid duplicate work;
reproduce the bug; if it's non-trivial, open an issue describing it and the proposed fix and wait
for a maintainer's nod; then fork → branch → small focused commit → PR with what/why/how-to-test.

**Q. Why are small pull requests better than one big one?**
Reviewers are time-limited volunteers; they can actually review a small, single-purpose change.
Big diffs are slow to review, hard to reason about, and often rejected or ignored. Small PRs merge
faster and build trust.

**Q. Difference between Continuous Delivery and Continuous Deployment?**
Both auto-build and auto-test. Delivery stops at a **ready-to-ship artifact** that a human can
release; Deployment **automatically releases** it to users with no manual step.

**Q. We're open-sourcing an internal tool. What licence questions matter, and why decide now?**
Pick permissive (maximise adoption / allow proprietary use) vs copyleft (force derivatives open),
and consider a patent grant (Apache 2.0) if patent risk matters. Decide **before** outside
contributions arrive: changing a licence later needs permission from every rights-holding
contributor.

**Q. Copyright vs patent vs trademark?**
Copyright protects the code (the expression) from copying — licences operate here. A patent protects
an invention/method — it can block someone who wrote their own code. A trademark protects a name/logo.
All three can apply to one piece of software.

**Q. Why does a project care about diversity beyond optics?**
A homogeneous group shares blind spots (users, languages, accessibility, edge cases). A broader
contributor base catches issues the original group can't see, so the software gets more robust.

**Q. A project depends entirely on one maintainer who just quit. What went wrong and how do you
prevent it?**
Bus-factor of one. Prevent it by mentoring co-maintainers early, documenting decisions and process,
and spreading review responsibility so the project survives any single person leaving.

## "Explain like the interviewer is non-technical"

- **Why open source at all?** "We can read, fix, and adapt the code ourselves instead of waiting on
  a vendor, it's cheaper, and more eyes on public code means more bugs caught."
- **Is open source less secure because everyone can see it?** "The opposite — more reviewers find
  more flaws. Hiding code isn't security; it just delays discovery."
- **What's CI/CD in one line?** "Automation that builds and tests every change so the main version
  always works, then ships it without slow manual steps."

## Connect it to your own work

For each, have a real sentence ready:

- A time you read a project's docs/issues before contributing or adopting it.
- A licence you chose (or would choose) for one of your repos, and why.
- Your closest thing to a CI/monitoring pipeline (e.g. an automated health-check/alert) and what it
  protects against.
- How you keep changes small and reviewable in your own commits.
