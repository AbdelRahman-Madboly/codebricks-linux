# Exercise 3: Investigate a Log Directory
Difficulty: Hard
Concepts: find, grep, grep -r, head, tail, less, absolute and relative paths

## Scenario
Your application has been writing logs to `/var/log` for weeks. A teammate reports that something went wrong overnight and asks you to find any lines mentioning "error" or "fail" across all log files, identify which file has the most recent entries, and check what the last 10 lines of that file say.

## Your Task
1. Use `find` to locate all `.log` files under `/var/log` that you have permission to read.
2. Use `grep -r` with a case-insensitive flag to search for the word "error" across the entire `/var/log` directory. Note how the output format differs from searching a single file.
3. Pick one log file from your results. Use `tail` to print its last 10 lines.
4. Open the same file in `less` and navigate to a line somewhere in the middle. Exit cleanly.
5. Use an absolute path for every command in this exercise — no relative paths.

## Check Your Work
You can explain the difference between what `find` returned and what `grep -r` returned. The `tail` output shows 10 lines. You exited `less` without killing the terminal. Every command you ran starts with `/`.
