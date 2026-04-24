---
name: new-project
description: Bootstrap a new software project with the user's required discipline - location in ~/dev, git-initialised from commit zero, incremental working commits, and test-first (loose TDD) development. TRIGGER proactively whenever the user asks to create / start / scaffold / bootstrap / build a new project, app, tool, service, library, script, or CLI - i.e. any request that would result in a brand-new codebase directory. Also trigger if the user says "let's build X from scratch" or similar. Do NOT trigger when merely adding files to an existing project.
---

# New Project Bootstrap Skill

You are helping Adam start a new project. Adam has strong, durable preferences about how new projects are set up and grown. This skill encodes those preferences — follow it precisely, even if the user's initial phrasing skips over some steps.

## Core rules (non-negotiable)

1. **Location**: The project lives at `~/dev/<project-name>` (lowercase, kebab-case). If the user suggests a different location, confirm before deviating.
2. **Git from commit zero**: `git init` happens *before or alongside* the first file creation. The very first commit should be either an empty scaffolding commit (just `.gitignore` + `README.md`) or a minimal working skeleton — never a big dump of finished code.
3. **Every commit is a working version**: If you can't run the project (or its tests) at a given commit and have them pass, don't commit yet. Broken commits are not allowed.
4. **Incremental commits**: Commit at every logical checkpoint — new feature passes tests, refactor complete, dependency added and verified. Small commits beat large ones. Don't let uncommitted work pile up.
5. **Test-first (loose TDD)**: For each new unit of behaviour, write the test first, watch it fail, then write the code to make it pass. The tests must clearly express the expected behaviour — readable as a spec. After green, review and refactor, then commit.
6. **Automated testing from day one**: A test runner must be wired up in the first scaffolding commit or the one immediately after. Do not write non-trivial feature code before the test harness runs.

## Workflow

### Step 1: Clarify the project

Before creating anything, confirm:
- **Project name** (kebab-case, becomes the dir name under `~/dev`)
- **Language / stack** (and therefore which test framework)
- **One-sentence purpose** (goes in the README)

Ask only what isn't already clear from the user's request. Don't over-interrogate — if they've said "make me a TypeScript CLI called foo-bar that does X", you have what you need.

**Default test frameworks by stack** (use unless the user specifies otherwise):
- Node/TypeScript → `vitest` (fast, TS-native, zero-config)
- Python → `pytest`
- Go → standard `testing` package
- Rust → built-in `cargo test`
- Shell → `bats`

### Step 2: Check the target directory

Run `ls ~/dev/<project-name> 2>/dev/null` to confirm it doesn't already exist. If it does, stop and ask the user what they want (use a different name, overwrite, or treat the existing dir as the project).

### Step 3: Scaffold + first commit

Create the minimum viable skeleton:
- `~/dev/<project-name>/` directory
- `.gitignore` appropriate to the stack (Node → `node_modules`, `dist`, `.env`, `.DS_Store`; Python → `__pycache__`, `.venv`, `dist`, `*.egg-info`, `.env`; etc.)
- `README.md` with the one-line purpose and a "Getting started" section that shows how to install deps and run tests
- Package/project file (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, ...) with test script wired up

Then:
```bash
cd ~/dev/<project-name>
git init
git add .
git commit -m "Initial scaffold"
```

Commit messages should be concise and follow the user's convention (see memory / recent repos if available — Adam's commit style is sentence-case, short, focused on the why).

Always append the Co-Authored-By trailer as per the main system prompt rules.

### Step 4: Wire up the test runner and commit a smoke test

Install/configure the test framework. Write one trivial passing smoke test (e.g. `expect(1 + 1).toBe(2)` or equivalent) purely to verify the runner works end-to-end. Run it. Commit:

```
Wire up test runner
```

This is the "test harness works" checkpoint. From here on, every feature follows the TDD loop.

### Step 5: Feature loop (repeat per unit of behaviour)

For every piece of functionality the user asks for:

1. **Red** — write a test that expresses the expected behaviour. The test name and assertions should read like a spec: future-you should be able to understand what the code does from the tests alone. Run the tests and confirm the new one fails for the right reason.
2. **Green** — write the minimum code to make the test pass. Don't over-build. Run all tests — they must all pass.
3. **Refactor** — review the code you just wrote for clarity, duplication, and simplicity. Tidy it up. Re-run tests — still green.
4. **Commit** — one commit containing the test + implementation + refactor. Message describes *what behaviour* was added, not *what files* changed.

If a test requires a supporting change (new dep, new file layout), it's fine to do a small prep commit first (e.g. "Add supertest dep for HTTP tests"). That prep commit should still leave the project in a working state.

### Step 6: Before handing back

When you reach a natural pausing point (feature complete, or user's request satisfied), verify:
- `git status` is clean (no uncommitted changes)
- All tests pass
- `README.md` still accurately describes how to run the project and tests

Then summarise what was built and what tests cover it.

## What to avoid

- **Don't write a big pile of code and then add tests at the end.** Tests come first, per unit.
- **Don't commit broken or half-finished states.** If you need to checkpoint, finish the current TDD cycle first.
- **Don't add tests just to satisfy the rule.** Tests that don't express real behaviour are worse than no tests. Each test should fail meaningfully if the behaviour regresses.
- **Don't scaffold outside `~/dev`** unless the user explicitly redirects you.
- **Don't skip the test-runner-works commit.** It's cheap insurance that the harness is real.
- **Don't batch commits.** If you've finished three features, that's three commits, not one.

## When the user pushes back

If the user says "just knock it out, no tests needed" or "skip the git setup", gently remind them of their standing preference (this skill exists because they asked for it) and offer a compromise (e.g. scaffolding tests only for the core logic, skipping UI-only tests). If they insist, follow their direct instruction for this session but don't update the skill — the rule stands for the default case.
