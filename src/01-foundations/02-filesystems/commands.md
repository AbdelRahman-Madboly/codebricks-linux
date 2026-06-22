# Commands — CH2: Filesystems
> Quick reference. Only commands first introduced in this chapter.

| Command | What it does | Ubuntu Example |
|---------|-------------|----------------|
| `pwd` | Prints the current working directory | `pwd` |
| `ls` | Lists contents of a directory | `ls ~/projects` |
| `cd` | Changes the current directory | `cd /var/log` |
| `cd ..` | Moves up one level to the parent directory | `cd ..` |
| `cd ~` | Goes to your home directory from anywhere | `cd ~` |
| `cat` | Prints full file contents to stdout | `cat app.log` |
| `head` | Prints the first N lines of a file | `head -n 5 data.csv` |
| `tail` | Prints the last N lines of a file | `tail -n 5 data.csv` |
| `less` | Opens a file for interactive scrolling | `less large_file.log` |
| `touch` | Creates an empty file, or updates its timestamp | `touch output.txt` |
| `mkdir` | Creates a new directory | `mkdir reports` |
| `mv` | Moves or renames a file or directory | `mv old.txt new.txt` |
| `cp` | Copies a file | `cp config.yaml config.yaml.bak` |
| `cp -R` | Copies a directory and all its contents | `cp -R src/ src_backup/` |
| `rm` | Deletes a file permanently | `rm temp.txt` |
| `rm -r` | Deletes a directory and all its contents permanently | `rm -r old_logs/` |
| `grep` | Searches file contents for a pattern | `grep "ERROR" app.log` |
| `grep -r` | Searches recursively through a directory | `grep -r "TODO" src/` |
| `find` | Finds files or directories by name | `find . -name "*.csv"` |

## Useful Patterns

```bash
# View a large log file with line numbers
cat -n app.log | less

# Watch the last lines of a growing log file in real time
tail -f /var/log/syslog

# Find all Python files modified recently
find . -name "*.py"

# Search all log files for a specific error
grep -r "ConnectionError" logs/

# Safely back up a config file before editing
cp config.yaml config.yaml.bak

# Go up two directory levels at once
cd ../..
```
