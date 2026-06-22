# 3 — System Administration

The running system misbehaving: memory pressure, services that won't stay up, users who can't work,
processes to inspect and kill, and the catch-all "it's slow." The skill is **narrowing**: deciding
*which resource* or *which layer* is the real bottleneck before you act.

Commands: [`reference/troubleshooting.md`](../../reference/troubleshooting.md#memory-pressure--oom);
hands-on: [`src/03-troubleshooting/03-system-admin`](../../../src/03-troubleshooting/03-system-admin/).

---

## Out of memory (and the OOM killer)

**Why it happens.** Demand for RAM exceeds physical memory plus swap. When memory runs out, the
kernel's **OOM killer** picks a process and kills it to save the system — which looks to a user like
"the app randomly died."

**How to diagnose.**

1. `free -h` — how much real memory and swap is actually free?
2. `top` (press `M`) or `ps aux --sort=-%mem | head` — which process is the hog?
3. `dmesg -T | grep -i 'killed process'` — did the OOM killer act, and on what? This explains the
   "mysterious" death.

**How to fix.** Restart/limit the offending process, or **add swap** as breathing room. Swap is
disk used as overflow memory: `fallocate` a swapfile → `chmod 600` → `mkswap` → `swapon`, then
persist it in `/etc/fstab`. Understand the trade-off: swap prevents OOM kills but is far slower than
RAM, so heavy swapping ("thrashing") is itself a cause of slowness — swap is a safety net, not a
substitute for enough memory.

## A service is down or keeps restarting

**Why it happens.** Bad config, a port already in use, a missing dependency, wrong permissions on a
file it needs, or it crashes on startup.

**How to diagnose (in order).**

1. `systemctl status <service>` — active? what was the last exit code? recent lines.
2. `journalctl -u <service> -n 100` (and `-p err`) — the actual error message.
3. Validate config **before** restarting (e.g. a service's own `-t`/test mode). Restarting without
   fixing the cause just loops the crash.
4. `ss -tulpn | grep :<port>` — is something else already holding its port?

**The crash-loop insight:** a service that restarts every few seconds is failing *on startup* — the
journal's first error after each start is the real cause, not the restart itself.

## Users can't work

Several distinct "user" problems, each with a specific cause:

- **No home directory.** A user whose home is missing lands in `/` (or nowhere) and can't save
  settings. Cause: account created without (or with a deleted) home. Fix: create it, set ownership,
  point the account at it. Check `/etc/passwd` for the home path.
- **Can't change password.** Often a policy (minimum age, complexity) or a permissions/PAM issue;
  the error message names which.
- **Can't run certain commands.** Either the command isn't on `PATH` (`echo $PATH`, `which <cmd>`),
  the binary lacks execute permission, or the action needs privilege the user doesn't have. Diagnose
  in that order: is it found? is it executable? is it allowed?

**The throughline:** "user can't X" splits cleanly into *identity* (who they are — `id`, groups),
*location* (home, PATH), and *permission* (file bits, sudo). Decide which before fixing.

## Inspecting and killing processes

**Why it matters.** Half of system admin is "what is this process and should it stop?"

- **Find it:** `ps aux`, `pgrep <name>`, or `top` for a live view.
- **Stop it gracefully:** `kill <PID>` sends `SIGTERM` — asks the process to clean up and exit.
- **Force it:** `kill -9 <PID>` sends `SIGKILL` — the kernel removes it with no cleanup. Use only
  when `SIGTERM` is ignored, because it can leave temp files/locks behind.
- **By name:** `pkill <name>` / `killall <name>`.
- **A stuck user session:** find their processes/terminal (`who`, `w`) and terminate them.

**The signal lesson:** always try the graceful signal first; `-9` is the last resort, not the
default. Knowing *why* `SIGKILL` is risky (no cleanup) is the point.

## "The system is slow" — narrow the bottleneck

This is the most open-ended scenario, and the whole skill is **isolating which resource**:

1. `uptime` — is load average high relative to core count (`nproc`)? High load with idle CPU points
   at I/O or memory waits, not CPU.
2. `top` — a runaway process pegging CPU? Or low CPU but high load?
3. `free -h` — swapping? Then it's **memory-bound** (see thrashing above).
4. `vmstat 1 5` — high `wa` (I/O wait) = **disk-bound**; high `si/so` = **swapping**.
5. `iostat -x` — which disk is saturated.
6. `df -h` — a full disk makes everything crawl; rule it out early.

**The framing to internalise:** "slow" is never the diagnosis — it's CPU-bound, memory-bound, or
I/O-bound, and each has a different fix. Find which *before* touching anything.

## Monitoring who and what

Part of admin is knowing the state: who's logged in (`who`, `w`, `last`), what's listening
(`ss -tulpn`), and capturing a system snapshot for support (a diagnostic bundle / "SOS" report that
packages logs and config for escalation). The habit: capture state *before* you start changing
things, so you can compare and so escalation has evidence.

## Kernel panic

**Why it happens.** A fatal kernel error — bad driver/module, corrupt memory, or a broken update —
halts the system; it can't safely continue.

**How to approach.** Recover by booting (recovery mode or a previous/known-good kernel), then read
`dmesg` / logs from after the failure to find the offending module or driver, and boot without it.
The mindset: a panic is the kernel refusing to risk corruption — treat it as "what changed at the
kernel/driver level," often a recent update or hardware.

## Rolling back updates and patches

**Why it matters.** When an update breaks the system, the fastest fix is often **reverting it**, not
debugging it live. Know that packages can be rolled back / downgraded and that booting a previous
kernel is a built-in escape hatch. The principle: a recent update is a prime suspect, and "undo the
change" is a legitimate, often fastest, resolution — which loops back to the methodology rule of
asking *what changed recently*.

---

## Check yourself

- What is the OOM killer and why does an app "randomly die"? How do you confirm it acted?
- What is swap, what does it prevent, and why is heavy swapping itself a problem?
- A service restarts every few seconds — where is the real cause, and what do you check before
  restarting it again?
- Break "user can't run a command" into the three things to check, in order.
- `SIGTERM` vs `SIGKILL`: which first, and why is `-9` risky?
- "The system is slow" — name the three bottleneck types and one command that distinguishes them.
- Why is a recent update a prime suspect for both kernel panics and general breakage, and what's the
  fastest class of fix?
