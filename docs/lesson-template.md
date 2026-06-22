# Lesson Template

Every chapter `README.md` follows this shape. It exists so each lesson teaches the same way:
short explanation, fast hands-on practice, and a check that I actually understood. When the tutor
and I build a new chapter live, we fill this in.

Keep explanations original and Ubuntu-flavored. The point of the README is to get me *doing*
things, not reading paragraphs.

---

```markdown
# CHn: <Chapter Title>

## Objectives
By the end of this chapter I can:
- <verb + concrete skill>
- <verb + concrete skill>
- <verb + concrete skill>

## Before You Start
> One command to run right now that you won't fully understand yet.
> We come back to it at the end.

## Concepts
For each concept:
- **What it is** — one or two plain sentences.
- **Try it** — the smallest command that shows it working.
- **Why it matters** — what breaks or gets painful without it.

## Practice Now
A short sequence of tasks to run in the terminal (or `practice/devstation/`).
Predict the output before running each one.

## Check Yourself
3–5 questions I should be able to answer out loud. If I can't, I'm not done.

## Common Mistakes
The two or three things that trip people up here.

## What's Next
One sentence linking to the next chapter.
```

---

## The other files in a chapter

| File | Who fills it | Contents |
|------|-------------|----------|
| `README.md` | tutor + me, live | the lesson (this template) |
| `notes.md` | **me only** | answers to the questions, in my own words |
| `commands.md` | me, as I go | quick reference for commands first seen this chapter |
| `exercises/` | tutor + me | `01-easy.md`, `02-medium.md`, `03-hard.md` scenarios |

`notes.md` and `commands.md` start as empty skeletons. The tutor never fills `notes.md` for me.
