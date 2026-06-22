# CH2: Filesystems

## Objectives
By the end of this chapter I can:
- Navigate the filesystem tree with `pwd`, `ls`, and `cd`.
- Tell absolute and relative paths apart and choose the right one.
- Read files with `cat`, `head`, `tail`, and `less`.
- Create, move, copy, and delete files and directories safely.
- Search file contents with `grep` and find files by name with `find`.

## Before You Start

Run this:

```bash
pwd
```

Then run this:

```bash
ls /
```

You just saw where you are, and what sits at the very top of your entire filesystem. Keep both in mind.

---

## The Big Picture

Everything on your machine — every file, every program, every config — lives somewhere in a single tree that starts at `/`. Knowing how to navigate that tree, read files, and manipulate them from the command line is the skill that unlocks everything else: writing scripts, debugging, managing servers, automating deployments.

---

## The Filesystem Tree

Your filesystem is a tree. It starts at a single point called the **root**, written as `/`. Everything branches from there:

```
/
├── home/
│   └── yourusername/
│       └── projects/
├── etc/
├── var/
└── usr/
```

Run `pwd` right now. The output is your **current location** in this tree — called your working directory. Every `/` in the path is a branch point.

---

## Navigating the Tree

Three commands you will use constantly:

```bash
pwd          # where am I?
ls           # what is here?
cd dirname   # move into a directory
```

Try it:

```bash
cd ~
pwd
ls
cd projects
pwd
ls
```

To go back up one level:

```bash
cd ..
pwd
```

`..` always means "the parent directory." You can chain it: `cd ../..` goes up two levels.

---

## Absolute vs Relative Paths

From your home directory, run both of these:

```bash
ls projects
ls /home/yourusername/projects
```

Same result. The difference:

- **Relative path** — `projects` — starts from wherever you currently are
- **Absolute path** — `/home/yourusername/projects` — always starts from root `/`, works from anywhere

Use relative paths when you know where you are. Use absolute paths in scripts or when the starting location is uncertain.

The `~` character is a shortcut for your home directory. `cd ~` always takes you home no matter where you are.

---

## Reading Files

```bash
cat filename.txt
```

`cat` prints the full contents of a file. For long files, that is too much at once. Use these instead:

```bash
head -n 5 filename.txt    # first 5 lines
tail -n 5 filename.txt    # last 5 lines
```

For files that are too long to fit on screen, use `less` — it lets you scroll:

```bash
less filename.txt
```

Inside `less`: `space` scrolls down, `b` goes back up, `q` quits.

---

## Creating and Organizing Files

Create an empty file:

```bash
touch newfile.txt
```

If the file already exists, `touch` updates its timestamp but does not overwrite it. Useful in scripts to guarantee a file exists.

Create a directory:

```bash
mkdir dirname
```

---

## Moving, Copying, Deleting

Rename a file or move it to another location:

```bash
mv oldname.txt newname.txt          # rename
mv file.txt somedir/                # move into a directory
mv file.txt somedir/newname.txt     # move and rename at once
```

Copy a file:

```bash
cp source.txt destination.txt
cp -R sourcedir/ destinationdir/    # copy a whole directory recursively
```

Delete a file:

```bash
rm file.txt
rm -r dirname/    # delete a directory and everything inside it
```

`rm -r` is permanent. There is no trash can. Think before you run it.

---

## Searching

Search file **contents** with `grep`:

```bash
grep "error" app.log              # find lines containing "error"
grep -r "error" logs/             # search all files in a directory recursively
```

Search for **files by name** with `find`:

```bash
find . -name "*.log"              # find all .log files from current directory
find /var/log -name "*error*"     # find files with "error" in the name
```

`grep` looks inside files. `find` looks for files by name. They are different tools for different questions.

---

## Practice Now

Do this whole sequence in a scratch directory (predict each result before running):

```bash
cd ~ && mkdir -p scratch/logs && cd scratch
touch logs/app.log notes.txt
ls -R
cp notes.txt logs/notes-backup.txt
mv notes.txt readme.txt
find . -name "*.txt"
grep -r "app" logs/      # returns nothing yet — why?
rm -r logs
ls
```

When you're done: `cd ~ && rm -r scratch` to clean up.

---

## Check Yourself
Answer these out loud before moving on:
1. You're deep in `/var/log/nginx/`. Two ways to get home — what are they?
2. When would an absolute path save a script that a relative path would break?
3. What's the difference between `rm -r` and `cp -R`, and why does one use `-r` and the other `-R`?
4. You want every line containing "timeout" across all files in `logs/` — `grep` or `find`?

---

## Common Mistakes
- Running `rm -r` without checking *where you are* first — there is no trash can, no undo.
- Reaching for `grep` when you wanted `find` (or vice versa): `grep` looks *inside* files,
  `find` looks *for* files.
- Forgetting that `~` and `/` are different starting points.

---

## What's Next

Chapter 3 covers permissions — who can read, write, and execute each file, and how to change that.
