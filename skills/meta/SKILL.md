---
name: meta
description: This skill should be used before the first response of every session in a forge workspace and before any task. It picks the kind of task and names the skill to load. Use it whenever a request arrives, even a question, even a one line fix, even when the kind seems obvious.
version: 0.1.0
---

# Meta

Every task is one of three kinds. Pick the kind. Load that skill. Nothing else.

| Kind | It is about | Skill |
|---|---|---|
| product | what a user of this workspace's product can do. a slice of their journey | `<project>-product`. the factory names it |
| code | a spec, a layer, a test, a gate inside a repo | code |
| platform | a repo, an engine, the factory, the register, a release | platform |

A task that spans two kinds is two tasks. Product first. It ends at the spec. Code picks up from the spec.

The product skill is the only one that knows the product. Every workspace brings its own. The factory `CLAUDE.md` names it.

Then the same steps every time.

1. Enter Plan mode. Ask with AskUserQuestion until nothing is ambiguous. Give options with tradeoffs. Never decide alone.
2. Show the design as a mermaid diagram. Name every adapter, controller, driver and type.
3. Wait for approval. Implement the plan and nothing else.
4. When something new comes up, stop and ask.
5. Done means `forge test-all` is green in every touched repo and the user tried it.

Read `FOLLOWUP.md` at the workspace root first. Update it when work changes state. Decided holds closed questions. Do not reopen one.

Write for the reader in front of you. Short words. Short sentences. No parenthesis. No dash. No semicolon. No comments in code. A test name is a full sentence.

## Source over docs

Documentation is assumed stale. Source is the truth. Before reading a checked out repo run `git fetch origin` and read at `origin/main` with `git show origin/main:<path>`. Local checkouts run behind.

The toolchain lives at `github.com/alexandremahdhaoui/forge`, `forge-ci`, `forge-factory`, `forge-register`, `forge-dev-codegen`. The reference workspace is `~/workspaces/golden`. The reference Rust shape is `golden-rust` and `opends`.
