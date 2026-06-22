# Exercise 3: Credential Hygiene on a Shared Server
Difficulty: Hard
Concepts: history, history -c, shell variables, security awareness

## Scenario
You are working on a shared Ubuntu server used by your team. During a debugging session earlier today you ran several commands that included an API key in plaintext. A teammate reminds you that shell history on shared machines persists across sessions and can be read by anyone with access to your home directory.

## Your Task
1. Clear your current session's command history so nothing from the debugging session remains.
2. Set a variable called `API_KEY` to any placeholder value.
3. Run a command that prints `Connecting with key: <your API_KEY value>` using the variable.
4. Verify that only the commands you ran after the clear are visible in history.

## Check Your Work
Running `history` shows only the commands you typed after clearing — the `API_KEY` assignment and the echo command are present, but no commands from before the clear appear. The printed line shows the variable's value, not the literal string `$API_KEY`.
