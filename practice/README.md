# Practice Environment — devstation

A simulated developer workstation. Run scripts against real-looking logs, configs, and data instead of toy examples.

## Setup

```bash
bash practice/setup.sh
```

This creates `practice/devstation/` (gitignored — regenerate anytime).

## What's inside

```
devstation/
├── logs/           ← app.log, access.log, auth.log, system.log
├── configs/        ← nginx.conf, webapp.service, crontab.example, hosts.example
├── scripts/        ← deploy.sh (has bugs), backup.sh (incomplete), monitor.sh (working), process_logs.sh (challenge)
├── data/           ← users.csv, api_logs.csv, servers.txt
└── scenarios/      ← structured troubleshooting scenarios with READMEs
```

## How to use it with chapters

| Chapter | What to practice |
|---------|----------------|
| 02-filesystems | Navigate and explore `devstation/` with `find`, `ls`, `cat` |
| 03-permissions | Scenario: `scenarios/01-permission-denied/` |
| 05-input-output | Pipe `logs/app.log` through `grep`, `wc`, `cut` |
| 06-packages | Nothing here — use your real system |
| 07-bash-scripting | Fix `scripts/deploy.sh`, complete `scripts/backup.sh`, study `scripts/monitor.sh`, implement `scripts/process_logs.sh` |
| 06-text-processing | Analyze `logs/access.log` and `data/users.csv` with `awk`, `sed`, `grep` |
| 03-troubleshooting | All scenarios in `scenarios/` |

## Resetting

Running `setup.sh` again wipes `devstation/` and starts fresh — no state persists between runs.

```bash
bash practice/setup.sh
```
