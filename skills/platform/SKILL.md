---
name: platform
description: This skill should be used for anything about the toolchain rather than the product. A new repo, a forge.yaml, a forge engine, the factory, the register, CI, a release, a toolchain binary, a workspace that will not sync. Use it whenever forge, forge-dev, forge-ci, forge-factory or forge-register is involved, even for a question.
version: 0.1.0
---

# Platform

Everything builds and tests through forge. Never a Makefile. Never a loose script. What forge cannot do is a forge engine.

## Verbs

```
forge build                      every artifact. lazy
forge test run <stage> [ENV_ID]  one stage. verb before stage. an env id reuses an environment
forge test-all                   every stage. fail fast
forge test create-env <stage>    stand an environment up and stop. prints the id
forge test delete-env <stage> <ID>
forge config validate            before trusting a forge.yaml
forge clone <factory url> <dir>  the whole workspace from nothing
forge-factory sync               writes manifests and .envrc
forge-ci apply --config forge-ci.yaml --root .
```

## A repo

Every repo has a `forge.yaml` and a `.envrc`. The factory writes `.envrc` and every manifest. A repo cannot build alone.

Rust wraps cargo through `forge://generic-builder` and `forge://generic-test-runner`. Scope clippy and fmt with `-p <crate>`. A build entry with `platforms:` is public and travels in the release. Windows is `x86_64-pc-windows-gnu` through `generic-builder`, never through `go-build`.

## An engine

An engine is an MCP server behind a `forge://` URI. forge-dev generates its shell from `forge-dev.yaml` and `spec.openapi.yaml`. Only the handlers are hand written. Two axes. `kind` is mcp-server, rest-api, cli or binary. `language` is go, rust, python or typescript. A testenv subengine exposes `create` and `delete` and returns files, env and managed resources. Forge owns the test id.

An engine names no project and no concrete technology it only orchestrates. If a decision cannot be written as a table test, it does not belong in an engine.

## Three transports, one shape

Every transport is a cell. rest-rust reads OpenAPI. grpc-rust-tonic and udp-rust read the same proto file, its service block being the handler map. Every transport emits the same layers, the controller trait, the struct with its ports and `new`, so one impl block can answer any of them. hexagonal-rust is the root cell. It emits `lib.rs`, the root layer mod files, the config schema, the build script and main. A UDP datagram is the udplb frame, one byte schema version from the proto package suffix, one byte FNV-1a hash of package.Service/Method, then prost bytes. Never a generator invented envelope.

## A cell

A cell is one directory with one `forge-dev.yaml` and one generator. The generator writes only inside that directory and never above it. That containment keeps cells composable and the checksum true.

The root cell owns `src/lib.rs`, the root layer mod files, the config schema, the crate build script and main. A transport cell such as `src/grpc/` owns its `forge-dev.yaml`, its `mod.rs` and the same layers one level down. `lib.rs` lists cells with a plain `pub mod grpc;` from the root cell's `layout.cells`. Never mount a generated file with `#[path]`. A cell that emits a test target and not a module, such as vectors, sits outside `src` as a cargo target. Every transport engine writes `zz_generated_cell.yaml` in its cell. It lists the drivers, adapters, controllers and ports the cell provides with their config fields and its build script. hexagonal-rust reads the manifests of the listed cells and `wiring.yaml`, named by `wiring.specPath` beside `openapi` and `proto`. It refuses a port with no adapter, a driver with no controller, a listed cell with no manifest, a duplicate driver and a choice naming nothing. It writes every choice and field into the `Spec` schema. `configGenerator` names the engine and its `outputDir`. configgen-gen emits the loader there. After every generator answers, forge-dev refuses a path not named `zz_generated`, sweeps files the previous run wrote and this run did not, and demands the manifest when the engine emits one. A module root skips that name. It carries the generated header instead.

## The factory

`forge-factory.yaml` lists every member and every shared version once. It generates `Cargo.toml`, `go.work`, every `go.mod` and every `.envrc`. Edit it only in the factory repo under `workspace/`. A member with no language gets no manifest. A member of the factory that is not in `forge-ci.yaml` builds and resolves locally and is never released from here.

`forge clone` places `FOLLOWUP.md` and `CLAUDE.md` from the factory.

## CI and release

Stages run in order. `check` validates every `forge.yaml`. `build` syncs and mints a revision after the gate passes. `publish` enters the register with that revision as provenance and releases the repos named in `releaseRepos`. One version tag. Only those repos get it.

A release is flat binaries named `name_os_arch` plus `index.json` with a sha256 digest each. A consumer trusts the digest and nothing else.

Never hand write a workflow. Declare it and apply. A repo must not track a file it also ignores. Repos the pipeline writes stay out of the watch list.

## Where to look

Source first. Docs are stale. Fetch and read at `origin/main`.

- forge and every builtin engine: `github.com/alexandremahdhaoui/forge`, `cmd/<engine>`. The engine contract is `pkg/engineframework` and `pkg/mcptypes`. URI resolution is `internal/engineresolver`.
- forge-dev and the generator model: `forge/cmd/forge-dev`. Non Go cells: `github.com/alexandremahdhaoui/forge-dev-codegen`.
- The pipeline: `github.com/alexandremahdhaoui/forge-ci`, `pkg/config` for the yaml types, `internal/controller/reconcilecontroller` for the loop.
- The factory: `github.com/alexandremahdhaoui/forge-factory`, `internal/controller/synccontroller` and `rendercontroller`.
- The register: `github.com/alexandremahdhaoui/forge-register`, `internal/types/regtypes`.
- A working factory to copy: `~/workspaces/golden/golden-factory` and its `workspace/` dir. A bootstrap to copy: `~/workspaces/qod/qod-factory`.

## Commits

One emoji first. ⚠ breaking. ✨ feature. 🐛 fix. 🌱 chore. 📖 docs. 🧹 tests and cosmetics. The pipeline reads it to bump the version. No assistant trailer. Ever.
