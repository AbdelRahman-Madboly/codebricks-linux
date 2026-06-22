# codebricks-linux

![Status](https://img.shields.io/badge/status-in%20progress-yellow)
![Platform](https://img.shields.io/badge/platform-Ubuntu%2024.04-E95420?logo=ubuntu&logoColor=white)
![Chapters](https://img.shields.io/badge/chapters-19-blue)

> Linux is not a tool I look up. It's where I live.

A hands-on Linux learning repository — from CLI basics to real-world troubleshooting. 19 chapters, 3 sections, one local practice environment. Every note, every command, every answer written by hand in the terminal.

---

## Table of Contents

- [About](#about)
- [Curriculum](#curriculum)
- [Getting Started](#getting-started)
- [Repo Structure](#repo-structure)
- [Progress](#progress)

---

## About

A structured Linux learning path built from the ground up — CLI fundamentals, system operations, and real-world troubleshooting. 19 chapters across 3 sections.

Each chapter follows the same structure: concepts in `README.md`, questions to answer in `notes.md`, a command reference to fill in yourself in `commands.md`, and hands-on scenarios in `exercises/`. The practice environment (`devstation/`) simulates a real developer workstation with logs, broken scripts, and troubleshooting scenarios.

---

## Curriculum

### Section 01 — Foundations
*CLI fluency. The commands used every day.*

| # | Chapter | Key skills |
|---|---------|-----------|
| 1 | [01-terminals-shells](src/01-foundations/01-terminals-shells/) | shell vs terminal, bash REPL, variables, export, history |
| 2 | [02-filesystems](src/01-foundations/02-filesystems/) | navigation, ls/cd, cat/head/tail, cp/mv/rm, find, links |
| 3 | [03-permissions](src/01-foundations/03-permissions/) | chmod, chown, sudo, octal, umask, setuid |
| 4 | [04-programs](src/01-foundations/04-programs/) | PATH, shebang, .bashrc, aliases, source, which |
| 5 | [05-input-output](src/01-foundations/05-input-output/) | pipes, redirection, exit codes, kill, ps, top |
| 6 | [06-packages](src/01-foundations/06-packages/) | apt, dpkg, vi basics |
| 7 | [07-bash-scripting](src/01-foundations/07-bash-scripting/) | variables, conditionals, loops, functions, set -e |
| 8 | [08-ssh-remote](src/01-foundations/08-ssh-remote/) | SSH keys, config, scp, rsync, tmux |

> **Milestone `v0.2.0`** — Section 01 complete. The Linux CLI is no longer a mystery.

---

### Section 02 — System Operations
*Manage a Linux system. Understand what's running and why.*

| # | Chapter | Key skills |
|---|---------|-----------|
| 1 | [01-users-groups](src/02-system-ops/01-users-groups/) | useradd/mod/del, /etc/passwd, /etc/shadow, su/sudo |
| 2 | [02-processes-services](src/02-system-ops/02-processes-services/) | systemctl, journalctl, ps/top/kill, crontab |
| 3 | [03-system-boot](src/02-system-ops/03-system-boot/) | GRUB2, boot sequence, systemd targets, recovery boot |
| 4 | [04-networking](src/02-system-ops/04-networking/) | ip addr/route, ss, ping, /etc/hosts, netplan, ufw |
| 5 | [05-storage](src/02-system-ops/05-storage/) | fdisk, lsblk, mount, /etc/fstab, LVM, mkfs, df/du |
| 6 | [06-text-processing](src/02-system-ops/06-text-processing/) | grep, sed, awk, sort/uniq/cut/wc/tr |

> **Milestone `v0.3.0`** — Section 02 complete. Can manage and understand a Linux system end-to-end.

---

### Section 03 — Troubleshooting
*Something broke. Find it, diagnose it, fix it.*

| # | Chapter | Key skills |
|---|---------|-----------|
| 0 | [00-methodology](src/03-troubleshooting/00-methodology/) | log-first, reproduce, isolate, document, escalate |
| 1 | [01-system-access](src/03-troubleshooting/01-system-access/) | server not reachable, SSH failures, firewall, DNS |
| 2 | [02-filesystem](src/03-troubleshooting/02-filesystem/) | permissions, disk full, LVM, fstab corruption, fsck |
| 3 | [03-system-admin](src/03-troubleshooting/03-system-admin/) | OOM/swap, service down, user problems, system slow |
| 4 | [04-system-recovery](src/03-troubleshooting/04-system-recovery/) | root password, single-user mode, VM/physical recovery |

> **Milestone `v1.0.0`** — All 19 chapters complete. Linux feels like home.

---

## Getting Started

**Prerequisites:** Ubuntu 24.04 (or any Debian-based system), bash.

**1. Clone the repo**
```bash
git clone https://github.com/AbdelRahman-Madboly/codebricks-linux.git
cd codebricks-linux
```

**2. Generate the practice environment**
```bash
bash practice/setup.sh
```
This creates `practice/devstation/` locally (gitignored) — a simulated developer workstation with realistic logs, configs, scripts with bugs, and troubleshooting scenarios.

**3. Start the first chapter**
```
src/01-foundations/01-terminals-shells/
├── README.md      ← start here — what this chapter covers
├── notes.md       ← questions to answer in your own words
├── commands.md    ← fill this in as you learn each command
└── exercises/     ← hands-on scenarios
```

**To reset the practice environment at any time:**
```bash
bash practice/setup.sh
```

---

## Repo Structure

```
codebricks-linux/
├── src/
│   ├── 01-foundations/        (8 chapters)
│   ├── 02-system-ops/         (6 chapters)
│   └── 03-troubleshooting/    (5 topics)
├── docs/
│   ├── cheatsheet.md          ← command reference, grows with each chapter
│   └── developer-reference.md ← gcc/compilation reference
├── practice/
│   ├── setup.sh               ← generates the practice environment
│   └── devstation/            ← generated locally, not committed
├── PROGRESS.md                ← chapter-by-chapter tracking
└── ROADMAP.md                 ← full chapter map with key skills per chapter
```

---

## Progress

| Section | Chapters | Status |
|---------|----------|--------|
| 01 — Foundations | 8 | Not started |
| 02 — System Operations | 6 | Not started |
| 03 — Troubleshooting | 5 | Not started |

Detailed tracking: [PROGRESS.md](PROGRESS.md)
