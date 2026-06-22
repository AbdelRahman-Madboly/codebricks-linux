# 02 — Filesystem

**Status:** Not started  
**Section:** 03-troubleshooting

---

## What this chapter covers

File and directory access problems. Disk full emergencies. LVM extension under pressure. Filesystem corruption recovery. Broken `/etc/fstab` (system won't boot). Each scenario gives you the symptom — you work out the cause and fix.

---

## Scenarios covered

1. Cannot `cd` into a directory (permissions)
2. Cannot execute a script (missing `+x`, bad shebang, Windows line endings)
3. Cannot find a file (using `find`, `locate`, hidden files)
4. Cannot create a hard link across filesystems
5. Disk full — identify and clean up
6. LVM — extend a logical volume online
7. Filesystem corruption — `fsck` in recovery mode
8. `/etc/fstab` error — system stuck at boot

---

## Files in this chapter

| File | Contents |
|------|----------|
| `notes.md` | Questions to answer in your own words |
| `commands.md` | Command reference — fill this in yourself |
| `exercises/` | Scenario descriptions |
