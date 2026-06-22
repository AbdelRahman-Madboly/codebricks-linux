# Interview Drills — Linux Troubleshooting

Cover the answer, say yours out loud, then check. Support/ops interviews love "walk me through how
you'd debug X" — so practice **narrating the order**, not just naming commands.

---

## Method

**Q. A service is reported down. What do you do in the first five minutes?**
Characterise (what's broken, who's affected, since when, what changed) → check logs
(`journalctl -u <svc>`, the app log) → confirm it's really down (`systemctl status`, hit the port) →
form one hypothesis, test it → restore service (restart if that's fastest) → then root-cause from the
logs → document.

**Q. Why "logs first"?**
The system already recorded what happened, with timestamps. Reading beats guessing, and the most
common real failure is simply that nobody looked.

**Q. Why never change two things at once?**
If the symptom clears you won't know which change fixed it, and you may have introduced new problems.
Cause and effect stay legible only with one change at a time.

**Q. Restore vs root-cause — which first during an outage?**
Restore. If a restart gets users working, do it, then investigate why from the logs you captured.
They're separate goals; don't let root-cause block restoration.

## Connectivity

**Q. "I can't reach the server." Walk me through it.**
`ping` the IP (link/host up?) → `ping` the hostname (works by IP but not name = DNS) → `ip addr`
(does it have the IP?) → `ip route` (gateway?) → `ss -tulpn` (service listening?) → `ufw status`
(firewall?). Stop at the first break.

**Q. Pings by IP but not by name — what is it?**
Name resolution (DNS). Check `/etc/hosts` (a stale entry overrides DNS) and `/etc/resolv.conf`.

**Q. SSH worked yesterday, now "permission denied (publickey)." First guesses?**
Key/permissions: `~/.ssh` must be 700, the private key and `authorized_keys` 600 — SSH refuses
world-readable keys. Then server policy (`PermitRootLogin`, `AllowUsers`) and that `sshd` is running.
`ssh -v` shows where it fails.

**Q. The app is down but the host pings fine. Where do you look?**
`ss -tulpn` for the port (nothing listening?), `systemctl status` + `journalctl -u` for the service,
then firewall. Reachable host + dead port = service problem.

## Filesystem & storage

**Q. `df` shows space free but writes fail. Two explanations?**
Inode exhaustion (`df -i`) — too many tiny files; or a deleted-but-open file holding space
(`lsof | grep deleted`) that only frees when its process restarts.

**Q. Which permission lets you delete a file?**
Write+execute on the *directory*, not the file. So you can delete a file you can't write, and fail
to delete one you own — the directory owns the namespace.

**Q. Disk is full. Walk me through it.**
`df -h` (which FS) → `df -i` (inodes?) → `du -sh /var/* | sort -rh` (drill into the biggest) →
`lsof | grep deleted` (hidden space). Clean old logs / rotate; the real fix is preventing unbounded
growth.

**Q. Hard link vs symlink?**
Hard link = another name for the same inode; can't cross filesystems or link directories. Symlink =
a pointer to a path; crosses filesystems, but breaks if the target moves.

**Q. Why is editing `/etc/fstab` dangerous, and how do you stay safe?**
A bad line can stop the boot into an emergency shell. Validate with `mount -a` before rebooting;
recover via recovery mode → remount root rw → fix the line.

## System admin

**Q. An app keeps getting killed at random. Cause and confirmation?**
Likely the OOM killer under memory pressure. Confirm with `dmesg | grep -i 'killed process'` and
`free -h`. Fix by limiting the hog or adding swap.

**Q. "The system is slow." How do you avoid guessing?**
Decide the bottleneck: `uptime`/`top` (CPU), `free -h` (memory/swap), `vmstat`/`iostat` (I/O wait).
"Slow" resolves to CPU-bound, memory-bound, or I/O-bound — each has a different fix.

**Q. `kill` vs `kill -9`?**
`kill` (SIGTERM) asks the process to clean up and exit — try this first. `-9` (SIGKILL) is forced,
no cleanup, can leave locks/temp files — last resort.

**Q. A service crash-loops. Where's the cause?**
On startup. Read the first error in `journalctl -u <svc>` after each restart, fix the config (test
it before restarting), and check nothing else holds its port.

## Recovery

**Q. Forgot the root password — how do you recover, and what does that teach about security?**
Edit the boot/kernel line to drop to a root shell, remount rw, `passwd`, reboot. Lesson: console/
physical access ≈ root — so protect the bootloader and physical access on real servers.

**Q. The box won't boot at all. Options?**
Recovery/single-user mode if it boots partway; otherwise a live USB → mount the disk → `chroot` in →
fix bootloader/`fstab`/files. On a VM, restoring a snapshot is often fastest.

**Q. What makes a backup a real backup?**
A tested restore. Untested backups fail when you need them. Define what, where, how often, and prove
the restore works — kept off the machine it protects.

## Connect it to your own work

Have a real sentence ready for each:

- A production incident you diagnosed log-first, and what the log told you.
- A disk-full or memory issue you hit on a real server, and how you found the cause.
- A change you made safely (backed up first, one thing at a time, verified after).
- Your closest thing to a runbook or documented procedure.
