---
name: provenance
description: This skill should be used when reviewing who decided. Load it for every provenance review, after a code review has passed. Use it whenever a batch is finished, even a small one, even when the code review found nothing.
version: 0.1.0
---

# Provenance

A code review asks whether the change is right. You ask whether it was ours to make.

## Two sources of truth, and nothing else

**The transcripts under `~/.claude/projects` and the task output files.** They record what was actually said to an agent and what it actually did.

**The git tree and its history.** It records what actually landed.

Everything else is a claim. **An agent's own report is evidence of nothing**, because the agent that dropped an instruction is the one writing the report. It may be mistaken, it may have forgotten, and it may be telling you what you want to hear. Never take a fact from a report. Use a report only to know where to look.

Read the tree first, then the transcript. Most findings live in the code, and the transcript answers whether a thing was a choice or an omission.

## The method that works

1. Extract the briefs an agent was given, out of the transcript.
2. For each instruction in a brief, look in the tree for evidence it was done.
3. If there is none, grep the transcript for that instruction. One hit and only one, the instruction itself, means it was dropped in silence.

A dropped instruction leaves no diff, so nothing but this finds it.

## Then read the rules

Then `CLAUDE.md`, `TENETS.md`, `METHODOLOGY.md`, `FOLLOWUP.md` and the plan. A choice is measured against what those said at the time, never against what they say now.

## The three questions

1. Could a reasonable person have chosen differently?
2. Does the difference change what gets built, what a player sees, or what a future change has to live with?

Both yes and it was the user's. Either no and it was tactical.

3. **For every instruction in the brief, is there evidence in the tree that it was done, refused or reported?**

Silence is a fail. The first two questions ask about a difference, so a choice that was never made passes both and walks straight through. This one catches it.

## When the fail is in the brief

The orchestrator writes the briefs and can be wrong. An instruction that broke a rule is a provenance failure whoever wrote it. Report both sides, name who wrote what, and send it to the user the same way.

## A tactical choice still fails if it broke a rule

Entropy. Did it add a parameter a caller must set, a hardcoded name, a branch over a closed set, a second spelling of one idea, or a default where a refusal by name belongs. Adding code is not a fault. Adding a knob is.

The layers. Driver to controller to port. No I O in a controller. No adapter importing an adapter. Nothing hand written that a generator should emit, with no exception.

The rest. Zero comments. Errors wrapping the action and the identifier. Test names as sentences. One emoji commit subject and no trailer. Simple words in every document.

## Fail on any of these

- A line under Decided reopened, narrowed or widened. In either direction.
- A gap filled by guessing where the answer was refused by name.
- A new key, dependency, transport or shape that nobody approved.
- Anything deleted that a person wrote.
- A rule left with an exception, however temporary.
- A green claimed against a tool nobody else runs.
- A tactical choice that added a knob.

## Report

Every choice you found, quoted from the transcript, with who made it and where. Marked user, tactical or unauthorised. For each unauthorised one, the rule it broke and what should have happened instead.

End with PASS or FAIL. A fail goes to the user, never fixed quietly. The point is that they learn what was decided for them.
