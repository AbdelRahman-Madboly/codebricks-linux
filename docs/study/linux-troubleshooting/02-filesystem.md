# 2 — Filesystem & Storage

Files you can't reach, write, or find; disks that fill up; partitions, links, and the mount table
that breaks a boot. Most of this reduces to two ideas: **permissions** and **space**.

Commands: [`reference/troubleshooting.md`](../../reference/troubleshooting.md#filesystem--disk-full--cant-write);
hands-on: [`src/03-troubleshooting/02-filesystem`](../../../src/03-troubleshooting/02-filesystem/).

---

## Reading permissions (the foundation for half this chapter)

**Concept.** `ls -l` shows `-rwxr-xr--` plus an owner and a group. Three triplets: owner, group,
others; each is read(4)/write(2)/execute(1). On a **directory**, execute means "may enter/traverse,"
and read means "may list names."

**Why it matters here.** Most "I can't…" filesystem errors are a permission bit or an ownership
mismatch. Before anything fancy, run `ls -la` on the target *and its parent directory* and read who
owns it and what the bits say. Check your own identity with `id` (your user and groups).

## Can't `cd` into a directory

**Why it happens.** You need **execute** (`x`) on a directory to enter it — read alone isn't enough.
Missing `x` on the directory (or any directory along the path) blocks you.

**How to diagnose.** `ls -ld <dir>` and walk the path. Fix with `chmod +x` (if you own it / are
permitted) or use appropriate privilege. The insight people miss: directory `x` is "pass through,"
directory `r` is "list" — they're different rights.

## Can't open a file or run a script

**Why it happens.** No read permission, or — for a script — no execute bit, or the wrong interpreter
line, or **Windows line endings**.

**How to diagnose.**

1. `ls -l <file>` — read/execute bits and owner.
2. For "permission denied" on a script: `chmod +x` it.
3. For "bad interpreter" / "No such file or directory" on a script that clearly exists: the shebang
   (`#!/bin/bash`) is wrong, or the file has `\r\n` line endings from Windows — the `\r` becomes
   part of the interpreter path. Fix the line endings (`dos2unix` or equivalent).

The `\r\n` trap is worth knowing cold: the error is bizarre ("not found" for a file you can see)
and the cause is invisible until you look for it.

## Trouble finding files

**Why it happens.** You're looking in the wrong place, the file is hidden (leading dot), or you need
a recursive search.

**How to diagnose.** `find / -name '<name>' 2>/dev/null` (the redirect hides permission-denied
noise), or a prebuilt index if available. `ls -la` reveals dotfiles. Understand `find` by **name**,
**type**, **size**, and **mtime** — those four predicates solve most searches.

## Can't create a link

**Why it happens.** Two link types, two rules:

- **Hard link** — another name for the *same inode*. Cannot cross filesystems and cannot link a
  directory. Trying to hard-link across mounts fails.
- **Symbolic (soft) link** — a small file that *points at a path*. Works across filesystems and to
  directories, but breaks if the target moves.

**The fix is usually conceptual:** if a hard link is refused, you're crossing a filesystem boundary —
use a symlink (`ln -s`) instead. Knowing *why* it failed is the whole lesson.

## Can't write to / delete / move / rename a file

**Why it happens.** Two different rights people conflate:

- **Writing to a file's contents** needs `w` on the **file**.
- **Deleting, renaming, or moving** a file needs `w` + `x` on the **directory** that contains it —
  not on the file itself.

**Why this is surprising.** You can delete a file you have *no* permission to write, if you can write
its directory; and you can be unable to delete a file you *own*, if the directory isn't yours. The
directory is the namespace; changing the set of names is a directory operation.

## Disk full

**Why it happens.** Logs grew unbounded, a runaway process wrote a huge file, old data never got
cleaned, or — the sneaky one — a deleted-but-still-open file is holding space.

**How to diagnose (in order).**

1. `df -h` — which filesystem is at 100%?
2. `df -i` — out of **inodes** rather than bytes? (Millions of tiny files exhaust inodes even with
   free space — a genuinely confusing "disk full with space left.")
3. `du -sh /var/* | sort -rh | head` — what's eating it; drill down into the biggest.
4. `lsof | grep deleted` — space held by a file that was deleted while a process still has it open;
   the space only returns when that process is restarted.

**The two traps to understand:** inode exhaustion (space free, still can't write) and deleted-open
files (`du` and `df` disagree). Both look impossible until you know they exist.

## Cleaning up old files (safely)

**Why care.** Unbounded growth (especially logs) is the usual root cause of "disk full." `find
/var/log -type f -mtime +30` lists candidates older than 30 days. **Review before deleting** — and
prefer rotation to manual `rm`. A scripted cleanup on a schedule prevents the incident entirely; the
lesson is that the real fix is *prevention*, not the emergency delete.

## Adding space: partitions and LVM

**Why it matters.** When a disk is genuinely full, you add storage. Two models:

- **Standard partition** — fixed size; growing it later is painful.
- **LVM (Logical Volume Manager)** — a flexible layer (physical volume → volume group → logical
  volume) that lets you **grow a filesystem online** by adding a disk to the group and extending the
  volume. This is *why* production systems use LVM: you can expand without downtime.

**The flow to know:** add disk → `pvcreate` → extend the volume group → `lvextend` the logical
volume → grow the filesystem (`resize2fs`). You don't need it memorised, but you should be able to
explain *why LVM exists*: elastic storage without repartitioning.

## Filesystem corruption and `fsck`

**Why it happens.** Unclean shutdown, power loss, or hardware faults leave filesystem metadata
inconsistent.

**How to fix — and the critical rule.** `fsck` repairs a filesystem, **but only on an unmounted
one** (or in recovery mode on the root filesystem). Running it on a mounted, live filesystem can
cause more damage. So serious filesystem repair means booting to recovery/single-user mode first.

## Broken `/etc/fstab` (a boot-stopper)

**Why it's dangerous.** `/etc/fstab` lists what to mount at boot. A bad line — wrong device, wrong
UUID, bad option — can **stop the boot** and drop you to an emergency shell. It's a small text file
with outsized blast radius.

**How to recover.** Boot to recovery, `mount -o remount,rw /` to make root writable, fix or comment
out the offending line, reboot. The preventive lesson: after editing `fstab`, validate it before
rebooting (e.g. `mount -a` to catch errors while you still have a shell) — never reboot on faith.

---

## Check yourself

- What permission lets you *enter* a directory vs *list* it? Which do you need to `cd` in?
- A script you can see gives "bad interpreter / not found." Two possible causes?
- Hard link vs symlink: which crosses filesystems, and what does the other one fail on?
- Which permission deletes a file — on the file or on its directory? Why is that surprising?
- `df` says space is free but writes fail. Give two reasons (hint: inodes; deleted-open files).
- In one sentence, why do production systems use LVM?
- Why must `fsck` run on an unmounted filesystem, and how does that change your procedure?
- Why is a one-line `/etc/fstab` mistake so dangerous, and how do you avoid rebooting into it?
