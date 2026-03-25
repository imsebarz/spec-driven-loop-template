# Spec-Driven Loop Template

A polished public starter for **spec-driven development (SDD)** with a lightweight autonomous loop (`ralph.sh`).

This template is built for teams and solo builders who want agents to work from **specs first**, keep a **living implementation plan**, and ship in **small verified increments**.

## Why this exists

Most agent workflows break down in one of two ways:

1. the agent starts coding before the product is specified
2. the plan drifts and nobody knows what is actually left

This template fixes that by making a few files first-class:

- `specs/*` → product and technical truth
- `IMPLEMENTATION_PLAN.md` → prioritized remaining work
- `PROMPT_discovery.md` → user interview + spec authoring
- `PROMPT_plan.md` → planning/audit loop
- `PROMPT_build.md` → implementation loop

## What’s included

- **Ralph Loop** (`ralph.sh`)
- **Discovery prompt** for interviewing the user and turning answers into specs
- **Planning prompt** for reconciling specs, code, and roadmap
- **Build prompt** for incremental implementation with tests
- **Implementation plan** skeleton
- **Operational guide** (`AGENTS.md`)
- **Starter specs**
- **MIT license**
- **Contributing guide**

## Philosophy

### 1. Specs are the source of truth
The loop should derive work from `specs/*`, not from vibes.

### 2. The plan is durable state
If the agent crashes, times out, or loses context, `IMPLEMENTATION_PLAN.md` is the recovery surface.

### 3. Small complete increments beat giant partials
The ideal build iteration:
- chooses one high-priority task
- implements it completely
- runs the required tests
- updates the plan
- commits the result

### 4. Tests verify outcomes, not implementation style
Each task in the plan should define what success looks like from the acceptance criteria.

## Repo structure

```text
.
├── AGENTS.md
├── CONTRIBUTING.md
├── IMPLEMENTATION_PLAN.md
├── LICENSE
├── PROMPT_build.md
├── PROMPT_plan.md
├── README.md
├── ralph.sh
├── scripts/
│   ├── discover-session.md
│   └── discover.sh
└── specs/
    ├── 01-architecture.md
    ├── 02-data-model.md
    ├── 10-ui-design.md
    └── 15-mvp-scope.md
```

## Quick start

### Requirements

- `git`
- `bash`
- one coding agent CLI:
  - `claude`
  - or `codex`

### 1. Clone and enter the repo
```bash
git clone https://github.com/imsebarz/spec-driven-loop-template.git my-app
cd my-app
```

### 2. Customize the specs
Edit `specs/*` until they actually describe your product.

### 3. Run discovery first if the product idea is still fuzzy
```bash
./scripts/discover.sh --agent claude
```

Use this mode when you want the AI to ask you questions about the product idea, target users, MVP, workflows, and architecture, then convert the answers into foundational specs. The script starts the agent with `PROMPT_discovery.md` so the first turn is already focused on product discovery.

Expected result:
- the AI interviews you in a few focused rounds
- raw answers can be captured in `scripts/discover-session.md`
- foundational `specs/*` files get authored or refined
- `IMPLEMENTATION_PLAN.md` is updated from the clarified scope

### 4. Run a planning pass
```bash
./ralph.sh plan 1
```

Expected result:
- specs reviewed
- source tree inspected
- `IMPLEMENTATION_PLAN.md` updated
- tasks prioritized
- verification outcomes clarified

### 5. Run build iterations
```bash
./ralph.sh build 5
```

Or with Codex:
```bash
./ralph.sh --agent codex build 5
```

Expected result:
- the top task is selected
- implementation happens in code, not just in docs
- required tests run
- the plan is updated
- completed work is committed

## Suggested cadence

### Planning loop
Use when:
- specs changed
- the repo drifted
- the plan feels stale
- the next task is unclear

```bash
./ralph.sh plan 1
```

### Build loop
Use when:
- the plan is already sane
- you want execution
- you want several incremental turns

```bash
./ralph.sh build 8
```

## Ralph loop behavior

The included `ralph.sh` is intentionally simple but practical.

It supports:
- `plan` mode
- `build` mode
- `claude` or `codex`
- iteration limits
- per-iteration logs in `.ralph-logs/`

It also includes a small amount of resilience:
- keeps logs for every iteration
- can auto-commit tiny interrupted changes
- can stash larger interrupted work
- helps future iterations recover from dirty state

## Example commands

```bash
# one planning pass
./ralph.sh plan 1

# five implementation iterations with Claude
./ralph.sh build 5

# eight implementation iterations with Codex
./ralph.sh --agent codex build 8
```

## Recommended spec set

These starter files are enough to begin:

- `01-architecture.md`
- `02-data-model.md`
- `10-ui-design.md`
- `15-mvp-scope.md`

Useful next additions:
- auth
- sync model
- error handling
- deployment model
- testing strategy

## Good usage patterns

### Do
- keep specs concrete
- keep the plan prioritized
- derive tests from acceptance criteria
- prefer shared modules over app-local duplication
- commit after meaningful increments

### Don’t
- let the loop code against an empty spec set
- leave placeholder scripts forever
- mix operational instructions into the product specs
- treat the plan as a status diary instead of a roadmap

## Making it your own

You’ll probably want to customize:
- commit scopes in `AGENTS.md`
- prompts in `PROMPT_plan.md` / `PROMPT_build.md`
- loop behavior in `ralph.sh`
- starter spec files for your product domain

## License

MIT
