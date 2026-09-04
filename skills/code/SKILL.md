---
name: code
description: This skill should be used for any change inside a repo. A spec change, a new endpoint, a proto, a layer, an adapter, a controller, a driver, a type, a test, a bug fix, a gate failure. Use it whenever code or a spec is about to be written or edited, even a one line fix, even when the user gives exact instructions.
version: 0.1.0
---

# Code

Change the spec first. Generate. Write only a decision. Test the decision. Run the gates.

## Shape

One crate per service. Five layers under `src`. A transport is a cell under `src` with the same five layers one level down. The platform skill says how a cell is laid out.

```
main -> driver -> controller -> port <- adapter
                      |
                    types
```

| Layer | Does | Never |
|---|---|---|
| driver | takes input. validates. calls a controller | touches an adapter |
| controller | decides. orchestrates ports | touches a driver. does I O |
| port | a trait the controller consumes. an adapter implements it | lives in types |
| adapter | implements a port. talks to one outside thing | decides. imports another adapter |
| types | plain data | holds a trait |

Box every port. A controller struct holds `Arc<dyn Port + Send + Sync>` fields. A controller never takes an adapter as a method argument.

The engine emits the trait, the struct with its ports and `new`, and a `mod <name>;` line in the layer `mod.rs`. The user writes `impl Trait for Struct` in `src/<cell>/controller/<name>.rs`. A missing file, method or impl is a compile error with a name. An adapter named in `wiring.yaml` works the same way. The only non generated Rust in a service is those impl files.

An adapter is named by what it talks to. `sqlite`. `memory`. `ses`. The day an adapter starts deciding, it is a service in disguise. Cut it out into its own spec and repo. One consumer is enough.

## Steps

1. Change the spec in the spec repo. Schemas. Paths. Proto. Vectors. Nothing is declared anywhere else.
2. Regenerate every consumer. `forge build`. Generated files are `zz_generated`. Never edit one.
3. Write the impl block the compiler demands. A controller decision or an adapter call. Nothing else.
4. Write the test for that body. Mock each port with `mockall::automock`. Name the test as a sentence. `an_unmapped_press_never_touches_the_keyboard_adapter`. Boundary tests are generated from vectors. Do not hand write one.
5. Errors nest with `#[source]`. Wrap with the action in present participle and the identifier. `main` walks the chain.
6. `forge test-all` in every touched repo. Then `forge test run e2e` in the e2e repo.

## Gates

Clippy `disallowed_methods` and `disallowed_types` are denied crate wide and allowed in the generated adapter and driver `mod.rs`. goldenpath-lint stops an I O crate in controller, port and types and a file no generated `mod.rs` reaches. forge-lint stops `use crate::adapter` in controller and driver. no-comment-lint stops a comment. forge-dev refuses a generated path not named `zz_generated` and sweeps stale files. There is no script to run. If a gate fails, fix the shape, never the gate.

## Where to look

Source first. Docs are stale. Fetch and read at `origin/main`.

- The built shape with three transports: `~/workspaces/songe/songe-hello`. `error_chain`: `~/workspaces/golden/golden-rust`.
- Spec, vectors and the int64 divergence: `~/workspaces/golden/golden-spec`.
- The generators: `github.com/alexandremahdhaoui/forge-dev-codegen`, one `cmd/<kind>-<language>-<library>` per cell.

## Never

- A comment. Rename or extract instead.
- A hand written test at a boundary. Add a vector.
- A second declaration file. The spec is the only source.
- Relaxing an assertion to go green. Fix the spec or the mapping.
