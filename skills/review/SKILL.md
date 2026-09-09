---
name: review
description: This skill should be used when reviewing a batch another agent built. Load it before reading any diff. Use it for every review, even a one file change, even when the builder reports every gate green.
version: 0.1.0
---

# Review

Verify claims by running them. A builder's report is a claim, not evidence.

First load the installed `code-review` skill and follow it for the diff itself. This skill adds what that one cannot know, the rules of this workspace.

## Run it yourself

`forge test-all` in every touched repo, in the foreground, from the real checkout. Never a scratch forge. Confirm `HEAD` equals `origin/main`. Then attack the claim the builder is proudest of, because that is the one nobody else will question.

## The workspace rules, checked every time

Load `TENETS.md`, `METHODOLOGY.md` and the root `CLAUDE.md`. Then the code skill for a repo change or the platform skill for an engine or the factory.

Generation. Is anything hand written that a generator should emit. There is no exception, not one adapter, controller, driver or type. If a shape resisted, the answer was to improve the generator.

Hexagonal. Driver to controller to port to adapter. A port trait sits with its consumer. An adapter talks to one outside thing and decides nothing. No I O in a controller. Constructor injection. Every port boxed.

Spec first. The spec changed before the code. Wire types never reach a controller. Every generated path is `zz_generated` and none was hand edited.

Entropy. Name every knob the batch removed and every one it added. A change that adds code and removes three knobs is a win. Never measure by size.

## Findings

File and line. What is wrong, and what right looks like. Do not soften a real finding and do not invent one to look thorough.

End with PASS or FAIL. A FAIL lists exactly what the builder must change.

## Never

- Edit a file. You are read only.
- Accept a number you did not reproduce.
- Pass something because the gates are green. Gates prove the shape, not the choice.
