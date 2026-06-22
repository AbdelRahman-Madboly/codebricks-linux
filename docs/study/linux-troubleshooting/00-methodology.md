# 0 — Method & Best Practices

Before any command: *how* to troubleshoot. A good method beats a big toolbox — it's what lets you
solve problems you've never seen before.

---

## 1. Understand before you touch

**Concept.** The first move is not a command — it's a question. What exactly is broken? Who is
affected (one user, everyone, one feature)? When did it start? What changed recently (a deploy, a
config edit, a full disk, a reboot)?

**Why it works this way.** Acting on a guess can make things worse and destroys evidence. "Recently
changed" is the single highest-value clue you can get — most incidents trace back to a recent
change. Asking the user costs seconds and often hands you the answer.

**In practice.** Get the precise symptom, not the summary. "It's slow" → slow to do *what*, for
*whom*, since *when*? "Can't log in" → which user, which method, what exact message?

## 2. Logs first — the system usually already told you

**Concept.** Before probing, read what the machine recorded. The cause is frequently sitting in a
log with a timestamp and an error string.

**Why it works this way.** Logs are the system's own account of what happened, in order. Reading
them turns guessing into reading. The most common real-world failure isn't a hard problem — it's
that nobody looked at the logs.

**Where to look:**

| Source | What's in it |
|--------|--------------|
| `journalctl -xe` | Recent journal with extra explanation — start here |
| `journalctl -u <service>` | Everything one service logged |
| `/var/log/syslog` | General system messages |
| `/var/log/auth.log` | Logins, `sudo`, SSH authentication |
| `dmesg -T` | Kernel buffer: hardware, drivers, out-of-memory kills |
| the app's own log | Often the real answer for an application issue |

## 3. Reproduce it

**Concept.** Trigger the problem yourself, deliberately.

**Why it works this way.** If you can't reproduce it, you can't be sure your "fix" did anything —
the symptom might have come and gone on its own. A reliable reproduction is also the fastest way to
test a hypothesis.

## 4. Isolate by halving

**Concept.** Narrow the problem space by cutting it roughly in half at each step, following a fixed
layer order, until the cause is cornered.

**Why it works this way.** Checking layers in a set sequence guarantees you never skip one and never
waste time re-checking. For connectivity that order is link → IP → routing → name resolution →
port/service → firewall → application. For "service down" it's process → config → port → dependency.

## 5. Change one thing at a time

**Concept.** Make a single change, then re-test, before making another.

**Why it works this way.** If you change three things and the symptom clears, you don't know which
one fixed it — and you may have introduced two new problems. One change at a time keeps cause and
effect legible. Back up any file before you edit it.

## 6. Verify, then document

**Concept.** Confirm the *original* symptom is gone (not just that "a" command now works), then
write down what happened.

**Why documentation matters.** A short record — symptom, timeline, root cause, fix, prevention —
means the next person (often future-you) doesn't re-investigate the same incident from zero. This is
also the difference between fixing an incident and preventing the underlying problem from recurring.

## 7. Know when to escalate

**Concept.** Escalate or call in a vendor/owner when: you've exhausted your checklist, the risk of
acting is high (data loss, wider outage), or you need access or authority you don't have.

**Why it works this way.** Stubbornly continuing past your competence or access is how a small
incident becomes a big one. Escalating with good notes ("here's what I checked and ruled out") is a
strength, not a failure.

## The priority rule under pressure

**Restore service first, root-cause later.** If a restart gets users working in two minutes, do it —
then investigate *why* it broke, from the logs you captured. Note what you did so the post-incident
analysis is honest. Speed of restoration and depth of root-cause are two different goals; don't let
the second block the first during an outage.

## Other professional habits

- **Follow policy and standards.** Use the agreed change process; don't cowboy a production box.
- **Be honest, ask questions.** "I don't know yet, I'm checking X" beats a confident wrong answer.
- **Patience with users.** They report symptoms, not causes — that's your job, not theirs.

---

## Check yourself

- What four things do you establish *before* running any command? Why is "what changed recently" so
  valuable?
- Why is "logs first" the most common thing people skip, and what do you lose by skipping it?
- Explain "isolate by halving" and give the layer order for a connectivity problem.
- Why never change two things at once?
- State the priority rule for an active outage and why restore and root-cause are separate goals.
- When is escalating the *right* call rather than a failure?
