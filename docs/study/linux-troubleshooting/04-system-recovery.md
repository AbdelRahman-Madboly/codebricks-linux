# 4 — System Recovery

When the system won't boot normally or you're locked out, you can't fix it from a normal login —
you need a way *in* from below. This chapter is about those entry points and the recovery mindset.

Commands: [`reference/troubleshooting.md`](../../reference/troubleshooting.md#recovery--locked-out--wont-boot);
hands-on: [`src/03-troubleshooting/04-system-recovery`](../../../src/03-troubleshooting/04-system-recovery/).

> Everything here is high-risk. Back up any file before editing it, and prefer a disposable VM /
> [`practice/devstation`](../../../practice/) to rehearse, never a system you can't afford to break.

---

## The core idea: get a root shell from outside the running system

**Concept.** Normal logins and `sudo` assume a working, booted system. Recovery techniques bypass
that — they give you a privileged shell *before* or *outside* the normal startup, so you can repair
the thing that's stopping a normal boot.

The three entry points, from least to most invasive:

1. **Boot-menu kernel edit** — interrupt the bootloader, tweak the kernel line to drop into a shell.
2. **Recovery / single-user mode** — a minimal boot to a root prompt with most services off.
3. **External media (live USB / rescue ISO)** — boot a *different* OS, then reach into the broken
   system's disk.

You escalate through these depending on how broken the system is.

## Recovering a forgotten root / lost admin password

**Why it works.** If you can edit the boot parameters, you can tell the kernel to start a shell
*instead of* the normal init — a shell that's already root and hasn't asked for a password.

**The approach.** Interrupt the bootloader (the GRUB menu), edit the kernel line to boot into a root
shell, remount the root filesystem read-write, set the new password, then hand control back to
normal startup (or reboot). 

**The security lesson hiding in this:** *physical/console access ≈ root.* Anyone who can reboot the
machine and reach the boot menu can do this. That's why production servers protect the bootloader
(a GRUB password) and physical access — the recovery trick that saves you is also the threat model.

## Single-user / recovery mode

**Why it exists.** Sometimes the system boots *most* of the way but a service, mount, or config
breaks the normal multi-user startup. Recovery mode boots a stripped-down environment — root shell,
minimal services, often read-only root — so you can fix the offending piece without the broken
service fighting you.

**The approach.** From the boot menu's advanced options, choose recovery mode, get the root shell,
remount read-write if needed, fix the config/service/mount, and continue booting. This is the right
tool for a broken `/etc/fstab`, a service that hangs the boot, or a bad config change.

## Recovering with external media (the system won't boot at all)

**Why you need it.** If the disk's own bootloader or root filesystem is too broken to reach even the
recovery shell, you boot from **separate media** (a live USB or rescue image) that doesn't depend on
the broken install.

**The approach (conceptually).** Boot the live environment → mount the broken system's filesystem →
optionally `chroot` into it so tools act *as if* running on that system → repair the bootloader,
`fstab`, or files → unmount and reboot. `chroot` is the key idea: it lets you run the broken
system's own commands and fix it from the inside while actually running off the rescue media.

## Physical vs virtual recovery

The toolkit is the same; the entry points differ:

- **Virtual machine.** You have extra escape hatches: **snapshots** (roll the whole VM back to a
  known-good point — often the single fastest recovery), console access through the hypervisor, and
  easy attach of a rescue ISO. The lesson: in virtual environments, *snapshot before risky changes*
  and recovery is frequently "restore the snapshot."
- **Physical machine.** No snapshot; you rely on the boot menu, recovery mode, live USB, and good
  backups. Recovery is slower and backups matter more, because there's no "undo button."

## The disaster-recovery mindset

**Concept.** Recovery isn't only the in-the-moment fix — it's the *preparation* that makes the fix
possible: knowing **what** to back up, **where**, **how often**, and — the part everyone skips —
**testing that the restore actually works.**

**Why it matters.** A backup you've never restored is a hope, not a plan. Untested backups fail at
the worst moment (wrong files, corrupt archive, missing step). The professional habit: rehearse
restores, keep backups off the machine they protect, and document the recovery procedure so it can
be followed under pressure by someone who isn't you.

**The throughline of this whole chapter:** the time to think about recovery is *before* the
incident. Snapshots, backups, a protected bootloader, and a written procedure are what turn a
catastrophe into a routine.

---

## Check yourself

- What do all recovery techniques have in common (what do they give you, and why can't a normal
  login provide it)?
- Walk through resetting a forgotten root password from the boot menu. What security fact does this
  reveal, and how do you defend against it?
- When is recovery/single-user mode the right tool rather than a live USB?
- What does `chroot` give you during a live-USB recovery, and why is it useful?
- Name two recovery advantages a VM has over a physical machine.
- Why is an untested backup not a real backup, and what three things define a backup plan besides
  "what to back up"?
