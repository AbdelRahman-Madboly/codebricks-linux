# Exercise 2: Session Summary
Difficulty: Medium
Concepts: shell variables, string interpolation, history, command review

## Scenario
You are starting a work session and want to document the session context as a single printed line, then verify that all your setup commands are logged.

## Your Task
1. Set three variables: `env`, `service`, and `owner` — use values that reflect a realistic dev context (e.g., staging, api-server, your name).
2. Print a single sentence using all three variables in the format: `env: X | service: Y | owner: Z`.
3. Run the history command and confirm that your three variable assignments and the echo command all appear in the output.

## Check Your Work
The history output shows exactly four relevant commands in sequence: three variable assignments followed by one echo. The printed sentence contains no literal variable names — only their values.
