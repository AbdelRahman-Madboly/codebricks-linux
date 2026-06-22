# Developer Reference — Linux Tools for Developers (M3)

> Not a chapter — a reference. You're Python/ML, not a C developer.
> Read once to understand what's happening under the hood. Come back when you need it.

---

## What this covers

Linux Tools for Developers Module 3 focused on C program compilation and development tools. This is a reference doc, not something to drill.

---

## The compilation pipeline (C)

```
source.c  →  [preprocessor]  →  source.i
                                    ↓
                             [compiler (cc1)]
                                    ↓
                              source.s  (assembly)
                                    ↓
                             [assembler (as)]
                                    ↓
                              source.o  (object file)
                                    ↓
                             [linker (ld)]
                                    ↓
                              executable (a.out or named)
```

**gcc commands:**
```bash
gcc -o myprogram source.c         # compile and link in one step
gcc -c source.c                   # compile to object file only (.o)
gcc -E source.c                   # run preprocessor only
gcc -S source.c                   # compile to assembly (.s)
gcc -Wall -Wextra source.c        # enable warnings
gcc -g source.c                   # include debug symbols (for gdb)
gcc -O2 source.c                  # optimize
```

---

## Why Python doesn't need this (but Python does it anyway)

Python source (`.py`) → bytecode (`.pyc` in `__pycache__/`) → CPython interpreter

When you `import` a module for the first time, Python compiles it to bytecode. The `.pyc` file is the equivalent of a `.o` file — a preprocessed form that loads faster.

When Python calls C extensions (numpy, scipy, many ML libraries), those extensions go through the full gcc pipeline. The `setup.py` / `pyproject.toml` build step IS the gcc step.

---

## What to know for troubleshooting

When a pip install fails with a C compilation error:
```
error: command '/usr/bin/gcc' failed
```

The fix is usually one of:
```bash
sudo apt install build-essential    # installs gcc, make, etc.
sudo apt install python3-dev        # installs Python C headers
sudo apt install libfoo-dev         # installs the C library you're linking against
```

---

## `make` and Makefiles

`make` is a build automation tool. It reads a `Makefile` and runs commands in order, skipping anything that's already up to date.

```makefile
# Simple Makefile
program: main.o utils.o
    gcc -o program main.o utils.o

main.o: main.c
    gcc -c main.c

clean:
    rm -f *.o program
```

Run with: `make` (builds default target) or `make clean`.

You'll see Makefiles in open source projects. You usually just run `make` or `make install`.

---

## Static vs shared libraries

| Type | Extension | What it means |
|------|-----------|--------------|
| Static | `.a` | compiled into your program at link time — bigger binary, no runtime dependency |
| Shared | `.so` | linked at runtime — smaller binary, but needs the `.so` present on the system |

If a program fails with `error while loading shared libraries: libfoo.so.1`, the `.so` is missing.
Fix: `sudo apt install libfoo1` or `sudo ldconfig`.

---

## `ldd` — see what libraries a binary needs

```bash
ldd /usr/bin/python3
ldd /usr/bin/ssh
```

---

## Package build tools (for reference, not drilling)

```bash
dpkg-buildpackage -us -uc    # build a .deb package from source
dpkg -i package.deb          # install a local .deb file
apt-get source package        # download source package
```

---

## `strace` — see what system calls a program makes

Useful when debugging a program that's failing silently:
```bash
strace python3 script.py 2>&1 | grep -E "open|read|write|error"
```

---

## `gdb` — debugger (awareness level only)

```bash
gdb ./program         # start debugger
(gdb) run             # run the program
(gdb) bt              # backtrace after a crash
(gdb) quit
```

You will mostly encounter `gdb` when reading crash reports from C extensions in Python packages.
