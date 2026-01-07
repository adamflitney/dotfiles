# Personal OpenCode Rules

## Plan Persistence Strategy

CRITICAL: To survive context compaction, always persist plans to disk.

### When Starting a Complex Task (3+ steps or non-trivial work):

1. **Create `.opencode/plan.md`** in the project root with:
   - Task overview and goals
   - Detailed step-by-step plan
   - Current status of each step
   - Any important context or decisions made

2. **Update `.opencode/plan.md`** after each significant step:
   - Mark completed steps with ✓
   - Update in-progress steps with current status
   - Add any new findings or changes to the plan
   - Include relevant file paths and line numbers

3. **Check `.opencode/plan.md` first** when:
   - Starting a new OpenCode session
   - User asks to "continue" or "resume"
   - You detect context might have been compacted
   - Beginning work in a project directory

### Plan File Format:

```markdown
# Current Task: [Brief Description]

**Status:** [Not Started / In Progress / Completed]
**Started:** [Date]
**Last Updated:** [Date and Time]

## Goal
[What we're trying to achieve]

## Plan
- [ ] Step 1: Description
- [x] Step 2: Completed description
- [⧗] Step 3: In progress description
  - Current status: [details]
  - Files modified: path/to/file.ts:123
- [ ] Step 4: Remaining work

## Context & Decisions
- [Important decisions made]
- [Key findings or constraints discovered]
- [Links to relevant documentation or files]

## Next Steps
[What should be done next when resuming]
```

### Important Notes:

- Save plans BEFORE making significant changes
- Update plans AFTER completing each step, not in batches
- Include enough context so you can resume without asking the user
- Keep the plan file even after task completion (for reference)
- If `.opencode/plan.md` exists on session start, read it immediately and summarize progress to the user

### Integration with TodoWrite Tool:

- Still use the TodoWrite tool for in-session tracking
- But ALSO persist the same information to `.opencode/plan.md`
- Think of TodoWrite as "working memory" and plan.md as "long-term memory"

### File Location:

- Always use `.opencode/plan.md` in the project root
- If multiple concurrent tasks, use `.opencode/plan-[feature-name].md`
- Add `.opencode/` to `.gitignore` (it's personal work-in-progress, not committed code)
