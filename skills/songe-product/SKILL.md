---
name: songe-product
description: This skill should be used in the Un Songe workspace when a task is about what a player can do. Use it for a new feature, a slice, a journey step, a screen, a flow, or any request that starts from the player rather than from the code. Use it even when the user asks for code, if the outcome is player facing. It ends at the spec and hands to the code skill.
version: 0.1.0
---

# Songe product

The product is Un Songe. Read `VISION.md`, `TENETS.md` and `USER-ACTIONS.md` at the workspace root. VISION.md is the user's own words and is never edited.

Work backward from the user. Stop at the spec.

## Steps

1. Read the user action list in the workspace. Every step has a service, a transport and a slice column.
2. Offer three cuts of the next slice. Smallest. Middle. Wide. Ask which one.
3. A slice is end to end and playable and minimal. Drivers and controllers are real. An adapter may be a stand in when the real thing is too much for now. Say which ones are stand ins.
4. For each step in the cut, name the service, the operation, the transport and the store it touches. Show it as one mermaid sequence diagram.
5. Turn the operations into spec changes. OpenAPI paths and schemas. Proto services. Vectors in `testdata/cases.json`. One vector per behavior with input, controller reply, expected output, expected error substring.
6. Stop. The code skill takes the spec from here.

## Rules

- Never widen a slice mid way. Finish it. Then pick the next one.
- A step that needs a new service is a new spec repo. Name it by its axis. experience, domain, platform, foundation.
- Mark the slice column in the user action list when the cut is agreed.
- A slice is done when the user played it on every target OS. Not when tests pass.
