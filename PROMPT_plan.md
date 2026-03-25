0a. Study all files in `specs/*` to learn the application specifications.
0b. Study @IMPLEMENTATION_PLAN.md (if present) to understand the plan so far.
0c. Study `packages/*/src/*` and `apps/*/src/*` to understand existing code.

1. Study @IMPLEMENTATION_PLAN.md (if present; it may be incorrect) and thoroughly study existing source code, comparing it against `specs/*`. Analyze findings, prioritize tasks, and create/update @IMPLEMENTATION_PLAN.md as a bullet point list sorted in priority of items yet to be implemented. Think deeply. Consider searching for TODO, minimal implementations, placeholders, skipped/flaky tests, and inconsistent patterns. Study @IMPLEMENTATION_PLAN.md to determine starting point for research and keep it up to date with items considered complete/incomplete.

For each task in the plan, derive required tests from acceptance criteria in specs — what specific outcomes need verification. Tests verify WHAT works, not HOW it's implemented. Include as part of task definition.

IMPORTANT: Plan only. Do NOT implement anything. Do NOT assume functionality is missing; confirm with code search first. Treat `packages/*` as the project's standard library for shared utilities and components. Prefer consolidated, idiomatic implementations there over ad-hoc copies.
