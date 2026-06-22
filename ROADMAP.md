# Roadmap — codebricks-linux

> Done = I can use it in the terminal without opening a browser.
> Progress tracked honestly in [PROGRESS.md](PROGRESS.md).
> Work each chapter with the tutor session in [TUTOR.md](TUTOR.md).

---

## Section 01 — Foundations

| # | Chapter | Key skills |
|---|---------|-----------|
| 1 | `01-terminals-shells` | shell vs terminal, bash, variables, export, history |
| 2 | `02-filesystems` | navigation, ls/cd, cat/head/tail, cp/mv/rm, find, links |
| 3 | `03-permissions` | chmod, chown, sudo, octal, umask, setuid |
| 4 | `04-programs` | PATH, shebang, .bashrc, aliases, source, which |
| 5 | `05-input-output` | pipes, redirection, exit codes, kill, ps, top |
| 6 | `06-packages` | apt, dpkg, nvim/vi basics |
| 7 | `07-bash-scripting` | variables, conditionals, loops, functions, set -e |
| 8 | `08-ssh-remote` | SSH keys, config, scp, rsync, tmux |

**Milestone: v0.2.0** — Section 01 complete. Linux CLI is not a mystery.

---

## Section 02 — System Operations

| # | Chapter | Key skills |
|---|---------|-----------|
| 1 | `01-users-groups` | useradd/mod/del, /etc/passwd, /etc/shadow, su/sudo |
| 2 | `02-processes-services` | systemctl, journalctl, ps/top/kill, crontab, at |
| 3 | `03-system-boot` | GRUB2, boot sequence, systemd targets, recovery boot |
| 4 | `04-networking` | ip addr/route, ss, ping, /etc/hosts, netplan, ufw |
| 5 | `05-storage` | fdisk, lsblk, mount, /etc/fstab, LVM, mkfs, df/du |
| 6 | `06-text-processing` | grep depth, sed, awk, sort/uniq/cut/tee/wc/tr |

**Milestone: v0.3.0** — Section 02 complete. I can manage and understand a Linux system.

---

## Section 03 — Troubleshooting

| # | Chapter | Key skills |
|---|---------|-----------|
| 0 | `00-methodology` | log-first, reproduce, isolate, document, escalate |
| 1 | `01-system-access` | server not reachable, SSH failures, firewall, DNS |
| 2 | `02-filesystem` | permissions, disk full, LVM, fstab corruption, fsck |
| 3 | `03-system-admin` | OOM/swap, service down, user problems, system slow |
| 4 | `04-system-recovery` | root password, single-user mode, VM/physical recovery |

**Milestone: v1.0.0** — All 19 chapters complete. Linux feels like home.

---

## Study & reference docs (alongside the chapters)

Beyond the hands-on chapters, finished course material is written up as study + reference docs:

- [`docs/study/`](docs/README.md) — read-to-study notes, one subfolder per finished course
  (open-source methods is done; more added as each course is completed).
- [`docs/reference/`](docs/reference/) — practical lookups: open-source licensing & contribution,
  starting a project, troubleshooting, developer tools.

---

## What comes after v1.0.0

- `codebricks-git` — **Git-specific** material only: Git internals, GitHub, branching, CI/CD
  pipelines (separate repo). Open-source *methods, licensing, and contribution* live **here** in
  `docs/`, not there.
- `codebricks-python` — Python OOP and beyond
