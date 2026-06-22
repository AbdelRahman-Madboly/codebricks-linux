# codebricks-linux

![Status](https://img.shields.io/badge/status-in%20progress-yellow)
![Platform](https://img.shields.io/badge/platform-Ubuntu%2024.04-E95420?logo=ubuntu&logoColor=white)
![Chapters](https://img.shields.io/badge/chapters-19-blue)
![Shell](https://img.shields.io/badge/shell-bash-4EAA25?logo=gnubash&logoColor=white)

> Linux is not a tool I look up. It's where I live.

A hands-on Linux learning repository — from CLI basics to real-world troubleshooting. Nineteen
chapters across three sections, one disposable practice environment, and an interactive
tutor-driven workflow. Every note, command, and answer is written by hand in the terminal.

---

## Table of Contents

- [What this is](#what-this-is)
- [How to work through it](#how-to-work-through-it)
- [Curriculum](#curriculum)
- [Getting started](#getting-started)
- [Repo structure](#repo-structure)
- [Progress](#progress)

---

## What this is

A structured, self-directed path to real Linux fluency — CLI fundamentals, system operations,
and troubleshooting. It is built to be *worked*, not read.

Each chapter has the same four parts:

| File | Purpose |
|------|---------|
| `README.md` | The lesson — objectives, concepts, and practice |
| `notes.md` | Questions I answer in my own words (no copy-paste) |
| `commands.md` | A command reference I fill in as I learn |
| `exercises/` | Hands-on scenarios |

Chapter 1 is a fully worked lesson and serves as the model. The remaining chapters start as
**briefs** (objectives + a concept checklist) and are built up interactively as I work through
them — so the content is genuinely mine, in my own words.

---

## How to work through it

This repo is designed to be studied with an **interactive tutor session**. The session prompt
lives in [`TUTOR.md`](TUTOR.md).

1. Generate the practice environment once: `bash practice/setup.sh`.
2. Open a fresh session in this repo and say: **"Read `TUTOR.md` and start my session."**
3. The tutor reads [`PROGRESS.md`](PROGRESS.md), picks up the current chapter, and teaches it
   hands-on — either in the **real terminal** (run commands, see output) or **in chat** when a
   terminal isn't handy.
4. I answer the chapter's questions in `notes.md` myself, build up `commands.md`, and work the
   exercises and troubleshooting scenarios.
5. A chapter is **done** only when I can do it from memory and explain *why* — no notes, no browser.

The lesson format every chapter follows is documented in
[`docs/lesson-template.md`](docs/lesson-template.md).

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

## Getting started

**Prerequisites:** Ubuntu 24.04 (or any Debian-based system) and bash.

```bash
# 1. Clone
git clone https://github.com/AbdelRahman-Madboly/codebricks-linux.git
cd codebricks-linux

# 2. Generate the practice environment (gitignored, regenerate anytime)
bash practice/setup.sh

# 3. Start a session
#    Open a session in this repo and say: "Read TUTOR.md and start my session."
```

The practice environment (`practice/devstation/`) simulates a developer workstation: realistic
logs, configs, account databases, command captures, buggy scripts, and eight troubleshooting
scenarios. Re-run `bash practice/setup.sh` anytime to reset it to a clean state.

---

## Repo structure

```
codebricks-linux/
├── TUTOR.md                   ← session prompt — point a session at this to start learning
├── README.md
├── ROADMAP.md                 ← full chapter map with key skills
├── PROGRESS.md                ← chapter-by-chapter tracking + session log
├── src/
│   ├── 01-foundations/        (8 chapters)
│   ├── 02-system-ops/         (6 chapters)
│   └── 03-troubleshooting/    (5 topics)
├── docs/
│   ├── lesson-template.md     ← the shape every chapter lesson follows
│   ├── cheatsheet.md          ← command reference, grows with each chapter
│   └── developer-reference.md ← compilation / toolchain reference
└── practice/
    ├── setup.sh               ← generates the practice environment
    └── devstation/            ← generated locally, not committed
```

---

## Progress

| Section | Chapters | Status |
|---------|----------|--------|
| 01 — Foundations | 8 | In progress |
| 02 — System Operations | 6 | Not started |
| 03 — Troubleshooting | 5 | Not started |

Detailed tracking: [PROGRESS.md](PROGRESS.md).
