# Spec-Driven Loop Template

A public starter template for **spec-driven development (SDD)** using a lightweight autonomous loop (`ralph.sh`) plus a living `IMPLEMENTATION_PLAN.md`.

This template is opinionated:

- Specs are the source of truth
- The plan is always current
- The loop alternates between **plan** and **build** work
- Every build increment should leave the repo in a better, more testable state
- Long-running agent work should be restart-safe

## What this gives you

- `specs/` for product and technical specifications
- `IMPLEMENTATION_PLAN.md` for prioritized remaining work
- `PROMPT_plan.md` to audit and refresh the plan
- `PROMPT_build.md` to implement the highest-priority task
- `ralph.sh` to run the loop with Claude Code or Codex
- `AGENTS.md` for repo-local operational guidance

## Recommended workflow

### 1. Write the specs first
Put product truth in `specs/*.md`.

Typical files:
- `01-architecture.md`
- `02-data-model.md`
- `03-editor.md`
- `10-ui-design.md`
- `15-mvp-scope.md`

### 2. Run a planning pass
```bash
./ralph.sh plan 1
```

This should:
- audit `specs/*`
- inspect the source tree
- update `IMPLEMENTATION_PLAN.md`
- define verification outcomes per task

### 3. Run build iterations
```bash
./ralph.sh build 8
```

This should:
- pick the highest-priority incomplete task
- implement a real increment
- run the required tests
- update `IMPLEMENTATION_PLAN.md`
- commit the work

### 4. Repeat
Use short loops. Planning loops keep the roadmap sane; build loops keep momentum.

## Core ideas

### Specs are truth
The loop should not invent product behavior. It should derive work from `specs/*`.

### The plan is living state
`IMPLEMENTATION_PLAN.md` is the recovery surface after crashes, token limits, or environment resets.

### Small complete increments beat giant partials
Prefer:
- one vertical slice
- tests included
- plan updated
- commit done

## Quick start

### Requirements
- `git`
- `bash`
- one coding agent CLI:
  - `claude`
  - or `codex`

### Run
```bash
chmod +x ./ralph.sh
./ralph.sh plan 1
./ralph.sh --agent codex build 5
```

## Repo structure

```text
.
├── AGENTS.md
├── IMPLEMENTATION_PLAN.md
├── PROMPT_build.md
├── PROMPT_plan.md
├── ralph.sh
└── specs/
    ├── 01-architecture.md
    ├── 02-data-model.md
    ├── 10-ui-design.md
    └── 15-mvp-scope.md
```

## Tips

- Keep `AGENTS.md` operational, not narrative
- Keep `IMPLEMENTATION_PLAN.md` prioritized
- Derive tests from acceptance criteria
- Commit early when the loop is doing meaningful work
- If the agent crashes often, prefer smaller build loops

## License

MIT
