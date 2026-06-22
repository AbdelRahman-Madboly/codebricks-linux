# CH1: Terminals and Shells

## Before You Read Anything

Open your terminal and run this:

```bash
echo $SHELL
```

Keep what you see in mind. By the end of this chapter you'll know exactly what that means and why it matters.

---

## The Big Picture

Every developer spends significant time issuing commands directly to the operating system — running scripts, installing packages, managing files, debugging. The terminal and the shell are the two tools that make this possible. They look like one thing but they are two separate programs working together.

---

## Terminal vs Shell

Run this:

```bash
whoami
```

Something read what you typed, figured out what it meant, ran a program, and printed the result. That something is the **shell**.

The **terminal** is just the window — it draws text on screen and sends your keystrokes somewhere. It has no idea what your commands mean.

The **shell** is the program behind it. On Ubuntu your shell is almost certainly Bash. Bash read `whoami`, evaluated it, printed your username, and is now waiting for your next command.

One more to make it concrete:

```bash
expr 99 + 1
```

The terminal showed you `100`. Bash did the math.

---

## The Shell is a REPL

You will hear this word constantly. REPL stands for:

- **R**ead — Bash read what you typed
- **E**val — Bash ran it (launched a program, did a calculation, whatever)
- **P**rint — Bash printed the result
- **L**oop — Bash is now waiting for the next command

Every command you type is one full REPL cycle. You have been using a REPL this whole time without knowing it. Python's interactive mode, Jupyter notebooks, and `node` all work the same way.

---

## Variables

Variables let you store a value and reuse it. Try this — no spaces around the `=`:

```bash
name="yourname"
echo $name
```

Now try it with spaces and see what happens:

```bash
name = "yourname"
```

Bash treats `name` as a command to run. No command called `name` exists, so it crashes. The rule: **no spaces around `=`** in variable assignment.

Now try string interpolation — putting a variable inside a sentence:

```bash
project="linux"
version="1.0"
echo "$project version $version is running"
```

Always use double quotes around strings that contain variables. Single quotes will print the literal `$variable` text instead of the value.

---

## History

Your shell logs every command you type. Run:

```bash
history
```

You can see everything from this session with line numbers. Use the **up and down arrows** to cycle through previous commands without retyping them.

To clear the screen without losing history:

```bash
clear
```

Run `history` again after — it is all still there.

To wipe the history entirely:

```bash
history -c
```

---

## Three Rules to Remember

1. Terminal = window. Shell = the program that runs your commands. They are not the same.
2. Never put spaces around `=` when assigning a variable.
3. `clear` clears the screen. `history -c` clears the history. They are different.

---

## What's Next

Chapter 2 covers the filesystem — how everything on your machine is organized into a tree, and how to navigate, read, create, move, and delete files from the command line.
