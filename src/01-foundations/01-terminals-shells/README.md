# CH1: Terminals and Shells

## What This Is
Every developer spends significant time issuing commands directly to their operating system — running scripts, installing packages, managing files, and debugging. The terminal and shell are the two tools that make this possible. Understanding what each one does, and how they work together, is the foundation for everything else in Linux work.

## Mental Model
Think of the terminal as the window and the shell as the brain behind it. The terminal emulator draws text on your screen and captures your keystrokes — the shell is the program that reads those keystrokes, figures out what to do, and prints the result. When you type a command, the terminal hands it to the shell, the shell runs it, and the terminal displays what came back.

## Key Concepts

### Terminal Emulator
A terminal emulator is a program that mimics what physical terminals used to do: accept keyboard input and display text output. On Ubuntu, common choices include GNOME Terminal (the default), Alacritty, and Ghostty. The terminal itself has no idea what your commands mean — that is not its job.

### Shell
The shell is the program that actually interprets and executes your commands. On Ubuntu, the default shell is Bash (Bourne Again Shell). The shell operates as a REPL: it Reads your command, Evaluates it by running another program or built-in, Prints the output, and Loops back waiting for the next input.

### Shell Variables
Bash lets you define variables to store values temporarily in your current session. You assign with `name="value"` — no spaces around the `=` — and access the value by prefixing the name with `$`. Variables are local to the current shell session and disappear when you close the terminal.

### Command History
Your shell keeps a running log of every command you type. The `history` command prints the full list with line numbers. You can cycle through previous commands with the up and down arrow keys without retyping. `clear` (or `ctrl+l`) wipes the visible screen without touching the history.

## Developer Connection
1. When you run `python main.py`, you are invoking the Python interpreter through the shell — the terminal just displays what comes back.
2. Shell variables are the simplest form of runtime configuration: set `API_KEY="..."` in your session and any script you run can read it from the environment.
3. The `history` command lets you recover a long pipeline or command sequence you ran during debugging without retyping it from memory.
4. Ghostty and Alacritty are popular terminal emulators among developers who want speed and configurability — relevant when setting up a fresh Ubuntu dev machine.
5. The REPL model is the same pattern as Python's interactive interpreter, Jupyter notebooks, and `node` — once you understand it in one context, it transfers everywhere.

## Try It Now
```bash
echo "Hello world"
# Hello world

whoami
# your-username

expr 100 + 42
# 142
```

## What's Next
Chapter 2 covers the filesystem — how directories and files are structured and how to navigate them from the command line.
