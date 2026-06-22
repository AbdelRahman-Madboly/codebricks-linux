# Commands — CH1: Terminals and Shells
> Quick reference. Only commands first introduced in this chapter.

| Command | What it does | Ubuntu Example |
|---------|-------------|----------------|
| `echo` | Prints text or a variable's value to stdout | `echo "Hello world"` |
| `whoami` | Prints the current logged-in username | `whoami` |
| `expr` | Evaluates an arithmetic expression and prints the result | `expr 123456 + 7890` |
| `history` | Prints the command history of the current shell session | `history` |
| `history -c` | Clears the current session's command history from memory | `history -c` |
| `clear` | Clears the terminal screen without deleting history | `clear` |

## Useful Patterns

```bash
# Search your history for a specific command you remember partially
history | grep python

# Set multiple variables and use them in a single string
service="api" && version="2.1" && echo "$service version $version"

# Clear the screen quickly without lifting hands off keyboard
# ctrl+l
```
