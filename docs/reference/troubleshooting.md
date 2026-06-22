# Troubleshooting Reference

A practical "how do I identify the problem" reference: the method first, then a symptom index, then
ordered command sequences per problem class. Ubuntu 24.04 / bash.

This is the *look-it-up-fast* layer. The hands-on chapters where you actually learn each area live
in [`../../src/03-troubleshooting/`](../../src/03-troubleshooting/); the broader command tables are
in [`../cheatsheet.md`](../cheatsheet.md).

---

## 1. The method (do this every time)

1. **Understand before you touch.** What's the symptom, who's affected, when did it start, what
   changed recently? Don't act on a guess.
2. **Look at logs first.** The system usually already told you what's wrong:
   `journalctl -xe`, `journalctl -u <service>`, `/var/log/syslog`, `/var/log/auth.log`,
   the app's own log.
3. **Reproduce it.** If you can't trigger it, you can't be sure you fixed it.
4. **Isolate by narrowing.** Cut the problem space in half each step (network? → host? → service?
   → config?). Follow a fixed order so you don't skip a layer.
5. **Change one thing at a time.** Multiple simultaneous changes mean you won't know what fixed it
   (or broke it further).
6. **Verify the fix** against the original symptom, then **document**: symptom, cause, fix,
   prevention.
7. **Know when to escalate:** you've exhausted your checklist, the risk of acting is high, or you
   need access/authority you don't have.

> **Priority rule under pressure:** restore service first, root-cause later. If a restart gets
> users working in two minutes, restart it — then investigate *why* it broke. Record what you did.

## 2. Symptom → first checks (quick index)

| Symptom | Look here first |
|---------|-----------------|
| Host unreachable | `ping` IP, then DNS, then `ip route`, then physical/VM state |
| Can reach host, app down | `systemctl status <svc>`, `ss -tulpn`, service log |
| "Permission denied" | `ls -la` the path, check owner/mode, group membership, `sudo` |
| Disk full / can't write | `df -h`, then `du -sh * \| sort -rh`, then old logs/files |
| Service won't start / keeps restarting | `journalctl -u <svc> -n 50`, check config syntax, ports, perms |
| System slow | `top` / `free -h` / `df -h` / `iostat`, then narrow CPU vs mem vs I/O |
| Out of memory / OOM kills | `free -h`, `dmesg \| grep -i oom`, top mem consumers, add swap |
| Can't SSH | `ssh -v`, key perms, `sshd` config, firewall, is `ssh` running |
| Boot fails / no root login | recovery/single-user mode, then `fsck` / fix `fstab` / reset password |

## 3. Problem class playbooks

Each is an **ordered** sequence — stop when you find the cause.
Detailed chapter: [`src/03-troubleshooting/`](../../src/03-troubleshooting/).

### System access — host or service unreachable

```bash
ping <ip>                       # is the host up at the IP level?
ping <hostname>                 # works by IP but not name? -> DNS problem
getent hosts <hostname>         # what resolution returns; check /etc/hosts, /etc/resolv.conf
ip addr show                    # does the host even have the expected IP?
ip route show                   # is there a default route / gateway?
ss -tulpn | grep :<port>        # is the service listening on the expected port?
systemctl status <service>      # is the service actually running?
sudo ufw status verbose         # is the firewall blocking the port?
```

Order = OSI-ish: link/IP → routing → DNS → port/service → firewall. See
[`01-system-access`](../../src/03-troubleshooting/01-system-access/).

### SSH specifically

```bash
ssh -v user@host                # verbose handshake shows where it fails
ls -ld ~/.ssh; ls -l ~/.ssh     # perms: ~/.ssh = 700, keys = 600, authorized_keys = 600
systemctl status ssh            # is the SSH server up on the target?
sudo journalctl -u ssh -n 50    # server-side reason for the reject
sudo grep -E 'PermitRootLogin|PasswordAuthentication|AllowUsers' /etc/ssh/sshd_config
```

### Filesystem — disk full / can't write

```bash
df -h                           # which filesystem is at 100%?
df -i                           # not space but inodes exhausted? (many tiny files)
du -sh /var/* | sort -rh | head # what's eating the full filesystem
sudo du -sh /var/log/* | sort -rh
find /var/log -type f -mtime +30 # old logs to rotate/remove (review before deleting)
lsof | grep deleted             # space held by a deleted-but-open file -> restart that process
```

See [`02-filesystem`](../../src/03-troubleshooting/02-filesystem/). For permission errors:
`ls -la` the path, confirm owner/group/mode, fix with `chmod`/`chown`, check group membership with
`id`.

### Service down / crash-looping

```bash
systemctl status <service>          # active? last exit code? recent log lines
sudo journalctl -u <service> -n 100 # the actual error
sudo journalctl -u <service> -p err # errors only
<config-test-cmd>                   # e.g. nginx -t, sshd -t: validate config before restart
ss -tulpn | grep :<port>            # is the port already taken by something else?
systemctl restart <service>         # restore service, then keep reading logs
```

See [`03-system-admin`](../../src/03-troubleshooting/03-system-admin/).

### Memory pressure / OOM

```bash
free -h                         # how much memory and swap is actually free?
top                             # press M to sort by memory; find the hog
ps aux --sort=-%mem | head      # top memory consumers, non-interactive
dmesg -T | grep -i 'killed process'  # did the OOM killer act, and on what?
# add temporary swap if genuinely out of RAM:
sudo fallocate -l 2G /swapfile && sudo chmod 600 /swapfile
sudo mkswap /swapfile && sudo swapon /swapfile   # persist via /etc/fstab afterward
```

### System running slow (narrow CPU vs memory vs I/O)

```bash
uptime                          # load average vs core count (nproc)
top                             # CPU%? a runaway process? load but idle CPU = I/O or mem wait
free -h                         # swapping? -> memory bound
vmstat 1 5                      # high 'wa' (io wait) -> disk bound; high 'si/so' -> swapping
iostat -x 1 3                   # which disk, how busy (needs sysstat)
df -h                           # a full disk makes everything crawl
journalctl --since "1 hour ago" -p warning   # recent warnings/errors
```

### Recovery — locked out / won't boot

- **Forgot root / sudo broken:** reboot → GRUB → edit kernel line → boot to a root shell →
  `passwd` / fix the bad file → reboot.
- **Single-user / recovery mode:** GRUB → *Advanced* → *Recovery mode* → root shell.
- **Broken `/etc/fstab` or filesystem:** boot recovery → `mount -o remount,rw /` → fix `fstab`
  (or `fsck /dev/sdX` on an **unmounted** filesystem) → reboot.

See [`04-system-recovery`](../../src/03-troubleshooting/04-system-recovery/). Treat anything here as
high-risk — back up the file you're about to edit first.

## 4. First 15 minutes of an incident

1. **Acknowledge** — note the start time; mark it "investigating."
2. **Characterise** — what's broken, who's affected, when it started, what changed.
3. **Investigate** — service status → logs → resources (`top`/`free`/`df`) → network → data.
4. **One hypothesis at a time** — state it, test it with one command, confirm or rule out.
5. **Restore** — apply the least-destructive fix; confirm the original symptom is gone.
6. **Document** — symptom, timeline, root cause, fix, prevention.

---

## Logs worth knowing by heart

| Path / command | What's in it |
|----------------|--------------|
| `journalctl -xe` | Recent system journal with explanations; start here |
| `journalctl -u <svc>` | Everything one service logged |
| `/var/log/syslog` | General system messages |
| `/var/log/auth.log` | Logins, sudo, SSH auth |
| `dmesg -T` | Kernel ring buffer: hardware, OOM, drivers (with timestamps) |
| `/var/log/<app>/…` | The application's own logs — often the real answer |
