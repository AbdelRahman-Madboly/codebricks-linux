# Exercise 2: Organize a Messy Directory
Difficulty: Medium
Concepts: mkdir, mv, cp, ls, rm

## Scenario
You have a directory full of files that need organizing. You need to create a structure, move files into the right places, make a backup copy of one of them, and clean up a file that should not be there.

## Your Task
1. Create a temporary working directory called `lab-fs` inside your home directory and navigate into it.
2. Create three files inside it: `report.txt`, `data.csv`, and `notes.md`.
3. Create two subdirectories: `docs` and `data`.
4. Move `report.txt` and `notes.md` into `docs`, and `data.csv` into `data`.
5. Copy `docs/report.txt` into the current directory (`lab-fs`) as `report.backup.txt`.
6. Delete the original `report.txt` from `docs`.
7. List the contents of `lab-fs` and both subdirectories to confirm the final state.

## Check Your Work
`lab-fs` contains `report.backup.txt`, a `docs` directory with only `notes.md`, and a `data` directory with `data.csv`. The original `report.txt` is gone from `docs`.
