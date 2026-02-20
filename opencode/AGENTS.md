# Personal OpenCode Rules

## GitHub Projects Integration

CRITICAL: This project uses GitHub Projects for task tracking. Follow this workflow for all code changes.

### When Creating a New GitHub Repository

When the user asks you to create a new GitHub repository:

1. **After creating the repo**, ask: "Would you like me to set up a GitHub Project for task tracking?"
2. **If yes**, run through the `/project-setup` workflow
3. **If no**, continue without project tracking (they can set it up later)

This ensures new repos can immediately benefit from ticket-driven development.

### On Session Start

When starting a session in a git repository:

1. **Check for project configuration:**
   - Look for `.opencode/project.json` in the project root
   - If it exists, read it to get project number and field IDs

2. **If no configuration exists:**
   - Check if this is a GitHub repo: `git remote get-url origin`
   - If it's a GitHub repo, ask the user: "No GitHub Project found for this repo. Would you like to set one up? (Run `/project-setup` to configure)"
   - If user declines or it's not a GitHub repo, continue without project tracking

3. **If configuration exists:**
   - Confirm project is accessible: `gh project view <number> --owner "@me" --format json`
   - Be ready to create/update tickets as work progresses

### Ticket-Driven Development Workflow

When implementing features or fixing bugs:

1. **Before making changes:**
   - Check if a ticket already exists for this work
   - If not, create a GitHub issue in the project:
     ```bash
     gh project item-create <PROJECT_NUMBER> --owner "@me" \
       --title "Brief description (max 50 chars)" \
       --body "Detailed description with acceptance criteria"
     ```
   - Move ticket to "In Progress" when you start work

2. **While working:**
   - Keep the ticket updated with progress
   - Link to relevant files and line numbers in ticket comments

3. **After completing changes:**
   - Move ticket to "Done"
   - Add a comment summarizing what was implemented and where

### Planning Mode vs Build Mode

The user can request two modes:

1. **Build mode (default):** Create/update tickets AND make code changes
2. **Plan mode:** Create/update tickets but DON'T make code changes
   - Use `/plan-only` command or when user says "just plan" or "tickets only"
   - Analyze requirements, create detailed tickets, but stop before writing code

### Ticket Granularity

- Create tickets for multi-step work (3+ changes or non-trivial features)
- For quick fixes or single-line changes, ask if user wants a ticket
- When in doubt, ask: "Should I create a ticket for this?"

### Important Notes

- Always preserve `.opencode/project.json` - never modify or delete it
- Use draft issues (via `gh project item-create`) for simplicity
- If `gh` commands fail, inform the user and continue without ticket tracking
- The project configuration is per-repo, not checked into git

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
