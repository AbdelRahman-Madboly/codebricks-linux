# Practice Environment — devstation

A simulated developer workstation. Run real commands against realistic logs, configs, account
databases, command captures, scripts, and structured troubleshooting scenarios — instead of toy
examples.

## Setup

```bash
bash practice/setup.sh
```

This creates `practice/devstation/` (gitignored — regenerate anytime).

## What's inside

```
devstation/
├── logs/         ← app.log, access.log, auth.log, system.log
├── configs/      ← nginx, systemd unit, crontab, hosts, netplan, fstab, resolv.conf
├── system/       ← fake passwd / group / shadow (safe to read and parse)
├── captures/     ← saved output of ps, ss, ip, lsblk, df, systemctl (parse without root)
├── data/         ← users.csv, api_logs.csv, servers.txt
├── scripts/      ← deploy.sh (bugs), backup.sh (incomplete), monitor.sh (working), process_logs.sh (challenge)
└── scenarios/    ← 8 structured troubleshooting scenarios, each with a README
```

## How it maps to the chapters

| Chapter | What to practice here |
|---------|----------------------|
| 02-filesystems | Navigate and explore `devstation/` with `find`, `ls`, `cat` |
| 03-permissions | `scenarios/01-permission-denied/` |
| 05-input-output | Pipe `logs/app.log` through `grep`, `wc`, `cut` |
| 07-bash-scripting | Fix `scripts/deploy.sh`, complete `scripts/backup.sh`, study `scripts/monitor.sh`, implement `scripts/process_logs.sh` |
| 09-users-groups | Parse `system/passwd`, `system/group`, `system/shadow` with `awk`/`grep` |
| 10-processes-services | Read `captures/ps-aux.txt`, `captures/systemctl-units.txt` |
| 12-networking | Study `configs/netplan.yaml`, `configs/resolv.conf`, `captures/ss-tulpn.txt`, `captures/ip-addr.txt` |
| 13-storage | Read `captures/lsblk.txt`, `captures/df-h.txt`, `configs/fstab.example` |
| 14-text-processing | Analyze `logs/access.log` and `data/*.csv` with `awk`, `sed`, `grep` |
| Section 03 troubleshooting | Work the 8 `scenarios/` in order |

## Resetting

Re-running `setup.sh` wipes `devstation/` and starts fresh — no state persists between runs.

```bash
bash practice/setup.sh
```
