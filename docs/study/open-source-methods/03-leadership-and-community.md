# Module 3 — Leadership, Community & Building Better Projects

What separates projects that grow from projects that die: how they're led, why most fail, why
diversity is a quality issue, and where projects live.

---

## 1. Leadership is not control

**Concept.** Good open source leadership **enables** contributors; it doesn't just restrict them.
A leader's job is to set direction, keep quality high, and remove blockers — not to be a gate that
says "no" by default.

**Why it works this way.** Contributors are volunteers. They can walk away at any moment and the
project has no power to stop them. So leadership runs on **influence and trust**, not authority. A
leader who only controls drives people off; a leader who mentors and delegates multiplies the
project's capacity.

**In practice.** Even the BDFL model (one founder with the final say) only works when that person
*listens, explains decisions, and mentors* — the "benevolent" part is what makes the "dictator"
part survivable. Control without trust is how projects fork or empty out.

## 2. Maintainers are made, not born

**Concept.** A **subsystem maintainer** owns review and acceptance for one part of a large project.
The skills the role needs — reviewing others' code, delegating, saying no diplomatically, spotting
risk — are **learned**, not innate.

**Why it works this way.** Promoting a strong coder straight into a maintainer role without
preparation usually fails: writing code and *shepherding other people's code* are different jobs.
So healthy projects **mentor future maintainers** — give them review responsibility gradually,
coach them, and build their judgment before handing over an area.

**In practice.** This is how a project scales past its founder and survives people leaving: a
pipeline of mentored maintainers means no single person is irreplaceable.

## 3. Trust is the real currency

**Concept.** In a distributed community of strangers, **trust** is what lets work flow — trust that
a contributor's code is sound, that a maintainer's review is fair, that the leader's decisions
serve the project.

**How trust is built.** Slowly and visibly: by consistently delivering good small contributions,
by reviewing others fairly, by following through on what you said you'd do, and by communicating
openly when things go wrong. It's earned through a track record, not granted by a title.

**Why it matters.** There's no manager, no contract, no office. Trust is the *only* coordination
mechanism. A project that erodes it (unfair reviews, broken promises, hostile communication) loses
contributors and stalls.

## 4. Why most OSS projects fail (and that's normal)

**Concept.** The large majority of open source projects never take off — and that's a healthy
feature of the ecosystem, not a tragedy. The barrier to *starting* is almost zero, so people
experiment cheaply; most experiments don't pan out, a few become foundational.

**Common, mitigable failure causes:**

| Failure cause | Mitigation |
|---------------|-----------|
| One maintainer who burns out or leaves (bus-factor of one) | Mentor co-maintainers early; document everything |
| No clear scope — the project tries to be everything | State what it is and isn't; say no to scope creep |
| Unwelcoming or hostile community | Code of conduct, fast friendly responses to newcomers |
| No documentation / impossible to contribute | `README`, `CONTRIBUTING.md`, good first issues |
| No real users or unmet need | Validate the need; solve a real problem |
| Leadership that controls instead of enables | Mentor, delegate, build trust |

**The reframing for an interview:** "most projects fail" isn't pessimism — it's *why the ecosystem
is so productive*. Cheap failure means lots of attempts, and today's giants (the kernel, the
dominant web server) all started as someone's small project.

## 5. Diversity as a quality driver

**Concept.** Diversity in a project — demographic, geographic, and **diversity of opinion** — makes
the *software better*, not just the community nicer.

**Why it works this way.** A narrow, homogeneous group shares the same blind spots: the same
assumptions about users, languages, accessibility, network conditions, and edge cases. A broader
contributor base surfaces problems the original group literally could not see. More perspectives →
fewer blind spots → more robust software.

**In practice.** Inclusion doesn't happen automatically — it takes active work: welcoming
newcomers, mentoring, a clear and **enforced** code of conduct, and constructive handling of
conflict. Foundations that steward big projects typically publish a code of conduct and actually
enforce it, because an unwelcoming community caps how many people will ever contribute.

## 6. Where projects live: hosting and Git

**Concept.** Modern OSS overwhelmingly lives on **web-based git hosting platforms** that provide
free public repositories, issue tracking, pull/merge requests, and CI integration.

**Why it works this way.** Free public hosting removed the last operational barrier to starting an
open project — you no longer need to run your own servers, mailing lists, and patch tooling. That
structural change is a big reason open source now dominates: anyone can start a public, contributable
project in minutes.

**Public vs private repositories:**

| | **Public** | **Private** |
|---|-----------|-------------|
| Who can see it | Anyone | Only invited collaborators |
| Use for | Open source, portfolio, shared community work | Proprietary code, work in progress, secrets, client work |
| Contribution model | Fork → PR from anyone | Direct collaborators only |

**Git's origin story (the one-liner).** The distributed version control tool that underpins all of
this was created to coordinate a huge, globally distributed kernel project after its previous tooling
became unavailable — built by the same community, for the scale of that community. That's why it's
*distributed* (every clone is a full copy) and why it scales to thousands of contributors.

> Git itself is a separate, deeper topic — covered in its own repo/track. Here it matters as the
> *enabler* of distributed collaboration.

---

## Check yourself

- Why is "leadership is not control" true specifically for *volunteer* communities?
- What does a subsystem maintainer do, and why must they be mentored first?
- How is trust built in a distributed project, and why is it the key coordination mechanism?
- Why is it healthy that most OSS projects fail? Name three failure causes and a mitigation for each.
- Explain how diversity improves the *software*, not just the community. What does enforcing a code
  of conduct have to do with it?
- When would you choose a public vs a private repository?
- In one sentence, why does free public git hosting matter to the OSS ecosystem?
