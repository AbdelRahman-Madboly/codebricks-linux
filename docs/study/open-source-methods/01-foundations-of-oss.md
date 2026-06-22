# Module 1 — Foundations of Open Source Software

What open source actually means, how it differs from proprietary software, where it came from, and
who steers it.

---

## 1. What "open source" means

**Concept.** Open source software ships with its source code under a licence that lets anyone
**read it, change it, and pass it on**. "Open" is about those rights, not about price.

**Why it works this way.** Software you only receive as a compiled binary is a black box — you
can't see what it does, can't fix it, can't adapt it. Publishing the source plus a permissive-or-
copyleft licence turns users into potential collaborators. The licence is what makes it open; code
posted publicly with *no* licence is still "all rights reserved" and legally untouchable.

**In practice.** When you land on a project you ask three questions: *Where is the source? What
licence is it under? Can I run, modify, and redistribute it under that licence?* If the answer to
the last one is yes, it's open source.

> **"Free software" vs "open source."** Same code, different emphasis. "Free" means *freedom*
> (libre), not zero cost — think free speech, not free beer. The term *open source* was popularised
> in 1998 specifically to stop people hearing "free" as "no money" and to make the idea easier to
> sell to businesses. The two communities overlap almost completely in practice.

## 2. Two licence families: permissive vs copyleft

This is the single most important distinction in the module.

| | **Permissive** (MIT, BSD, Apache 2.0) | **Copyleft** (GPL family) |
|---|---|---|
| Can I modify and keep my changes closed? | **Yes** | **No** — derivatives must stay open |
| Obligation when I distribute? | Keep the notice | Release your source under the same licence |
| Mental model | "Do almost anything, just credit me" | "Share-alike: improvements come back to everyone" |
| Good for | Maximum adoption, libraries | Keeping a whole ecosystem open |

**Why it works this way.** Permissive licences optimise for *spread* — a company can build a
product on MIT-licensed code without being forced to publish their own. Copyleft optimises for
*reciprocity* — if you benefit from the code, the community benefits from your changes. Neither is
"better"; they encode different goals.

**In practice.** Copyleft is **"sticky upward"**: if any part of what you ship is GPL, the whole
combined work generally has to be GPL too. That one rule drives most real-world licence decisions.
Full decision tree and compatibility table: [`oss-and-licensing.md`](../../reference/oss-and-licensing.md).

## 3. The proprietary model, for contrast

**Concept.** Proprietary software keeps the source private. You get a binary and a licence that
restricts copying, modifying, and redistributing. Sharing internals usually requires an NDA.

**Why it works this way.** The business model is selling access to something only the vendor can
change. That can fund large polished products — but it also means users depend entirely on the
vendor to fix bugs, add features, or keep the product alive. If the vendor loses interest or goes
under, users are stuck.

**In practice.** The trade-off you should be able to articulate: proprietary = controlled,
supported, opaque, lock-in risk; open = transparent, adaptable, self-supportable, but you may own
more of the integration work.

## 4. Pragmatism vs idealism — why people choose OSS

Two different motivations push people toward open source, and good arguments come from both:

- **Idealist / ethical.** Software increasingly runs society — voting, banking, healthcare,
  infrastructure. Code that can't be inspected can't be trusted or audited. Transparency is a
  public good.
- **Pragmatic / engineering.** Open code is cheaper to adopt, easier to debug, avoids vendor
  lock-in, and gets stronger as more people use and review it.

**Security through transparency.** A key pragmatic argument: more eyes on the code means more bugs
found and fixed. This is the opposite of *security through obscurity* (hoping attackers won't find
flaws because the code is hidden) — which fails the moment someone does look.

## 5. A short history (the shape, not the dates)

You don't need exact years; you need the **arc**:

1. **1950s–60s** — software shipped *with* source by default; sharing code among researchers and
   between companies was normal.
2. **1970s–80s** — software became a separately sold, closed product; the "free software" movement
   formed in reaction, arguing users should keep the freedom to study and change their tools.
3. **1990s** — a free Unix-like kernel plus a free toolchain produced a complete open operating
   system; the term *open source* was coined (1998) to make the idea business-friendly.
4. **2000s onward** — open source became the default for infrastructure: web servers, databases,
   languages, container and cloud-native tooling, and the version-control tool the whole world now
   uses. Big companies shifted from hostile to dependent.

**The lesson of the arc:** open source didn't win on ideology alone — it won because the
*collaborative model produced better infrastructure faster* than any single vendor could.

## 6. Governance — who actually decides

Open projects still need a way to make decisions. Three common models:

| Model | Who decides | Strength | Risk |
|-------|-------------|----------|------|
| **Company-led** | A sponsoring company sets direction | Resources, focus, paid maintainers | Direction serves the company; community feels like guests |
| **BDFL** (Benevolent Dictator For Life) | One trusted founder has the final say | Fast, coherent vision | Bus-factor of one; burnout; succession is hard |
| **Governing board / open process** | Elected or appointed group, written rules | Survives any single person leaving; neutral | Slower; more process overhead |

**Why it works this way.** A project's governance has to match its size and stakes. A weekend
library is fine as a BDFL. Infrastructure that many companies depend on usually moves to a
**foundation / board** model so no single person or company can capture or kill it.

**In practice.** When evaluating whether to depend on a project, governance is a real signal:
*Who can merge? What happens if the lead disappears? Is there more than one active maintainer?*

## 7. Why OSS helps each kind of stakeholder

Be able to give one benefit per audience:

- **Users** — freedom to inspect, adapt, and not be locked to one vendor; community support.
- **Businesses** — lower cost, no per-seat licence trap, ability to fix things themselves, shared
  maintenance of "plumbing" they all need but none want to own alone.
- **Educators / students** — real production code to read and learn from, for free.
- **Developers** — public portfolio, faster learning from review, reuse instead of rebuild.

**Collaborative "plumbing."** A powerful idea: competitors can jointly maintain the boring shared
infrastructure (the plumbing) and still compete on the product built on top. Everyone's costs drop.

## 8. Landmark projects (know ~five and why each matters)

| Project | Why it's significant |
|---------|---------------------|
| The Linux kernel | Proof that a globally distributed volunteer+corporate effort can build world-class infrastructure; classic BDFL-with-maintainers governance |
| The distributed version-control tool everyone uses | Built to coordinate that kernel's contributors; now the substrate of nearly all collaboration |
| The dominant open web server | Showed open source could win in serious production and spawned a major foundation model |
| The GNU toolchain (compiler, core utilities) | The free building blocks that made a fully open OS possible |
| Cloud-native / container tooling | Modern wave: foundation-governed projects that became industry standards |

---

## Check yourself

- Define open source without using the word "free." Now explain the two meanings of "free."
- Permissive vs copyleft: what obligation does each put on someone who distributes a modified
  version? What does "sticky upward" mean?
- Give one idealist and one pragmatic argument for open source. What is "security through
  obscurity" and why is it weak?
- Sketch the historical arc in four steps without dates.
- Compare company-led, BDFL, and board governance — one strength and one risk each.
- Name one OSS benefit for a *business* and one for a *student*. Explain "shared plumbing."
- Name five major OSS projects and say in one line why each matters.
