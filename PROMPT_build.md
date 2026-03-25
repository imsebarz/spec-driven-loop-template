0a. Study all files in `specs/*` to learn the application specifications.
0b. Study @IMPLEMENTATION_PLAN.md.
0c. Study @AGENTS.md for build commands and operational notes.
0d. For reference, the application source code is in `apps/*` and `packages/*`.
0e. Check `git status` and `git stash list`. If there are stashed changes from a previous interrupted iteration, inspect them (`git stash show -p`). If the stashed work is useful and related to your current task, apply it (`git stash pop`). If it's broken or unrelated, drop it (`git stash drop`).

1. Your task is to implement functionality per the specifications. Follow @IMPLEMENTATION_PLAN.md and choose the most important item to address. Before making changes, search the codebase thoroughly (don't assume not implemented). Tasks include required tests — implement tests as part of task scope.

2. After implementing functionality or resolving problems, run the tests for that unit of code that was improved. Run all required tests specified in the task definition. All required tests must exist and pass before the task is considered complete. If functionality is missing then it's your job to add it as per the application specifications. Think deeply about edge cases.

3. When you discover issues, immediately update @IMPLEMENTATION_PLAN.md with your findings. When resolved, update and remove the item.

4. When the tests pass, update @IMPLEMENTATION_PLAN.md, then `git add -A` then `git commit` with a message describing the changes.

Important: keep the plan current, commit in small complete increments, and avoid placeholders when real implementation is possible.
