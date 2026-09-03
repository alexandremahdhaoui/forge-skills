---
name: code
description: This skill should be used for any change inside a repo. A spec change, a new endpoint, a proto, a layer, an adapter, a controller, a driver, a type, a test, a bug fix, a gate failure. Use it whenever code or a spec is about to be written or edited, even a one line fix, even when the user gives exact instructions.
version: 0.1.0
---

# Code

Change the spec first. Generate. Hand write only a decision. Test the decision. Run the gates.

## Shape

Two crates per service. The compiler holds the edge.

```
core   types. port. controller. pure. depends on common only
app    adapter. driver. bin. depends on core and common
```

```
main -> driver -> controller -> port <- adapter
                      |
                    types
```

| Layer | Does | Never |
|---|---|---|
| driver | takes input. validates. calls a controller | touches an adapter |
| controller | decides. orchestrates ports | touches a driver. does I O |
| port | a trait in `core/src/port/<name>.rs`. the controller consumes it | lives with its implementer |
| adapter | implements a port. talks to one outside thing | decides. imports another adapter |
| types | plain data | holds a trait |

Injection is generic and stored in `new`. `Arc<dyn Trait>` only where a framework forces it. A controller never takes an adapter as a method argument. That is what makes drivers hold adapters.

An adapter is named by what it talks to. `sqlite`. `postgres`. `ses`. The day an adapter starts deciding, it is a service in disguise. Cut it out into its own spec, core and app. One consumer is enough.

## Steps

1. Change the spec in the spec repo. Schemas. Paths. Proto. Vectors. Nothing is declared anywhere else.
2. Regenerate every consumer. `forge build`. Generated files are `zz_generated`. Never edit one.
3. Write the one body the generator left for you under `src/hand`. A controller decision or an adapter call. Nothing else.
4. Write the test for that body. Mock each port with `mockall::automock`. Name the test as a sentence. `an_unmapped_press_never_touches_the_keyboard_adapter`. Boundary tests are generated from vectors. Do not hand write one.
5. Errors nest with `#[source]`. Wrap with the action in present participle and the identifier. `main` walks the chain.
6. `forge test-all` in every touched repo. Then `forge test run e2e` in the e2e repo.

## Gates

The crate edge stops core from reaching app. Clippy `disallowed_methods` stops I O in core. `cargo-deny` stops I O crates in core. A forge lint stops a driver importing an adapter and a public item nobody calls. There is no script to run. If a gate fails, fix the shape, never the gate.

## Where to look

Source first. Docs are stale. Fetch and read at `origin/main`.

- Rust layer shape and `error_chain`: `~/workspaces/golden/golden-rust`.
- Pure core with a gated purity split: `~/workspaces/opends/opends-core` and `opends-app`.
- Spec, vectors and the int64 divergence: `~/workspaces/golden/golden-spec`.
- The generators: `github.com/alexandremahdhaoui/forge-dev-codegen`, one `cmd/<kind>-<language>-<library>` per cell.

## Never

- A comment. Rename or extract instead.
- A hand written test at a boundary. Add a vector.
- A second declaration file. The spec is the only source.
- Relaxing an assertion to go green. Fix the spec or the mapping.
