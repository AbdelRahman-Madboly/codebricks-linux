# CH1: Terminals and Shells

## Objectives
By the end of this chapter I can:
- Explain the difference between a terminal and a shell, and what each one is responsible for.
- Describe the shell as a REPL and name what each letter does.
- Set and use variables correctly, including string interpolation.
- Inspect and manage my command history.

## Before You Start

Open your terminal and run this:

```bash
echo $SHELL
```

Keep what you see in mind. By the end of this chapter you'll know exactly what that path means
and why it matters.

---

## Terminal vs Shell

Run this:

```bash
whoami
```

Something read what you typed, figured out what it meant, ran a program, and printed the result.
That something is the **shell**.

The **terminal** is just the window — it draws text on screen and sends your keystrokes
somewhere. It has no idea what your commands *mean*.

The **shell** is the program behind it. On Ubuntu your shell is almost certainly **Bash**. Bash
read `whoami`, evaluated it, printed your username, and is now waiting for your next command.

One more, to make it concrete:

```bash
expr 99 + 1
```

The terminal showed you `100`. Bash did the math. The terminal just carried the characters.

> **Why it matters:** when something "doesn't work in the terminal," it's almost always the shell
> (or the program it ran) that has an opinion — not the window. Knowing which layer you're talking
> to is the first debugging move.

---

## The Shell is a REPL

You will hear this word constantly. REPL stands for:

- **R**ead — Bash read what you typed.
- **E**val — Bash ran it (launched a program, did a calculation, whatever).
- **P**rint — Bash printed the result.
- **L**oop — Bash is now waiting for the next command.

Every command you type is one full REPL cycle. You've been using a REPL this whole time without
knowing it. Python's interactive mode, Jupyter, and `node` all work the same way.

---

## Variables

Variables let you store a value and reuse it. Try this — **no spaces around the `=`**:

```bash
name="yourname"
echo $name
```

Now break it on purpose:

```bash
name = "yourname"
```

Bash treats `name` as a *command* to run. No command called `name` exists, so it errors. The
rule: **no spaces around `=`** in an assignment.

Now string interpolation — putting a variable inside a sentence:

```bash
project="linux"
version="1.0"
echo "$project version $version is running"
```

Always use **double** quotes around strings that contain variables. Single quotes print the
literal `$variable` text instead of the value — try it and see.

---

## History

Your shell logs every command you type. Run:

```bash
history
```

You can see everything from this session with line numbers. Use the **up/down arrows** to cycle
through previous commands without retyping them.

Clear the screen without losing history:

```bash
clear
```

Run `history` again after — it's all still there. The screen and the history are different things.

Wipe the history entirely:

```bash
history -c
```

---

## Practice Now

Predict the output *before* you press Enter on each line:

```bash
city="Cairo"
echo "I live in $city"
echo 'I live in $city'
greeting="hello" && name="world" && echo "$greeting $name"
history | grep echo
```

Did the single-quote line surprise you? That's the lesson sticking.

---

## Check Yourself
Answer these out loud before moving on:
1. If you swapped the terminal for a different one but kept Bash, what would change for you?
2. Why does `name = "value"` fail when `name="value"` works?
3. Open two terminal windows, set a variable in one — can the other see it? Why?
4. Does `clear` touch your history? Does `history -c`?

If any answer is shaky, go back up and re-run the relevant section.

---

## Common Mistakes
- Putting spaces around `=` in an assignment.
- Using single quotes when you meant to expand a variable.
- Assuming `clear` wiped your history (it didn't).

---

## What's Next
Chapter 2 covers the **filesystem** — how everything on your machine is organized into a tree,
and how to navigate, read, create, move, and delete files from the command line.
