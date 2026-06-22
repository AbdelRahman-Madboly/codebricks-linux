# Linux Troubleshooting

Study notes for diagnosing and fixing real Linux problems — the *thinking*, not just the commands.
This is the read-to-understand layer for the troubleshooting specialization (fundamentals,
intermediate, advanced + recovery).

> My own notes, in my own words. Everything is written for Ubuntu 24.04 / bash.

---

## Three layers, and where this fits

| I want to… | Go to |
|------------|-------|
| **Understand** a class of problem and how to reason about it | **here** (`docs/study/linux-troubleshooting/`) |
| **Look up** the exact command sequence fast, mid-incident | [`../../reference/troubleshooting.md`](../../reference/troubleshooting.md) |
| **Practice** hands-on with a tutor and broken scenarios | [`../../../src/03-troubleshooting/`](../../../src/03-troubleshooting/) + [`../../../practice/`](../../../practice/) |

These study docs deliberately spend their words on the **why** and the **diagnostic order**. When
you just need the commands, jump to the reference; it has the terse playbooks.

## The docs

| # | Topic | What it covers | Doc |
|---|-------|----------------|-----|
| 0 | **Method & best practices** | How to approach any problem: log-first, reproduce, isolate, one change at a time, document, escalate | [00-methodology.md](00-methodology.md) |
| 1 | **System access** | Host unreachable, app/website down, SSH failures, firewall, name resolution | [01-system-access.md](01-system-access.md) |
| 2 | **Filesystem & storage** | Permissions, can't cd/open/write, finding files, links, disk full, partitions/LVM, fsck, fstab | [02-filesystem.md](02-filesystem.md) |
| 3 | **System administration** | Memory/OOM/swap, services down, users, slow systems, processes, kernel panic, updates rollback | [03-system-admin.md](03-system-admin.md) |
| 4 | **System recovery** | Root password reset, single-user/recovery mode, repairing physical and virtual systems, DR mindset | [04-system-recovery.md](04-system-recovery.md) |

Then test yourself: [interview-drills.md](interview-drills.md).

## The one idea behind all of it

**Diagnose in a fixed order so you never skip a layer, and never change two things at once.** Almost
every scenario below is an application of that. The order for connectivity is link → IP → routing →
name resolution → port/service → firewall → application. The order for "it's broken" in general is
*understand → logs → reproduce → isolate → fix one thing → verify → document.*
