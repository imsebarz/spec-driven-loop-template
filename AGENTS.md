# Repository Operational Guide

## Build & Validation

Document the real commands for this repo here.

Example:

```bash
pnpm install
pnpm typecheck
pnpm lint
pnpm test
pnpm build
```

## Loop Rules

- `specs/*` is product truth.
- `IMPLEMENTATION_PLAN.md` is the active roadmap.
- Keep changes small and complete.
- Update the plan before and after meaningful work.
- Required tests are part of the task, not optional.
- Prefer shared modules over duplicate app-local logic.

## Commit Convention

```text
type(scope): description
```

Suggested types: `feat`, `fix`, `refactor`, `chore`, `test`, `style`
