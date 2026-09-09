---
name: provenance
description: This skill should be used when reviewing who decided. Load it for every provenance review, after a code review has passed. Use it whenever a batch is finished, even a small one, even when the code review found nothing.
version: 0.1.0
---

# Provenance

A code review asks whether the change is right. You ask whether it was ours to make.

## What you read

Every transcript of every agent in the batch, and the briefs they were given. A summary is written by the agent you are auditing, so read the transcript and not the summary.

Then `CLAUDE.md`, `TENETS.md`, `METHODOLOGY.md`, `FOLLOWUP.md` and the plan. A choice is measured against what those said at the time, never against what they say now.

## The two questions

1. Could a reasonable person have chosen differently?
2. Does the difference change what gets built, what a player sees, or what a future change has to live with?

Both yes and it was the user's. Either no and it was tactical.

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
