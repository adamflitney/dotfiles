---
name: self-reflect
description: >
  Analyze the current conversation to identify friction, wasted effort, and missing context,
  then suggest concrete improvements. Use when user says "reflect on this session",
  "self-reflect", "session retrospective", "what could be improved", "what went wrong",
  "how can future sessions go smoother", "capture learnings", "review this session", or
  asks for a post-session review. Also trigger when user asks "what should I add to
  CLAUDE.md based on this conversation" or "what friction happened".
version: 1.0.0
---

# Session Reflection Skill

Analyze the current Claude Code conversation to identify friction points, then suggest concrete improvements to CLAUDE.md, skills, MCP servers, memory, or hooks. Every suggestion must be grounded in something that actually happened — never generate generic advice.

## Phase 1: Gather Existing Setup

Before analyzing friction, read what already exists so suggestions are not redundant. Run these in parallel:

1. **CLAUDE.md files** — Read all that exist:
   - Project root `CLAUDE.md` (check current working directory)
   - `~/.claude/CLAUDE.md` (global)
   - Any nested `CLAUDE.md` files found via `Glob` for `**/CLAUDE.md`

2. **Memory** — Read `~/.claude/projects/*/memory/MEMORY.md` if it exists (use Glob to find the right project path)

3. **MCP servers** — Run `claude mcp list` via Bash to see installed integrations

4. **Installed skills** — Run `ls ~/.claude/plugins/cache/` via Bash and list what's installed

5. **Hooks** — Check for `.claude/hooks/` or hook configuration in `.claude/settings.json`

Store a mental inventory of what's already configured. You will use this in Phase 4 to filter out redundant suggestions.

## Phase 2: Analyze Current Conversation

Review the full conversation history visible to you. Apply the six friction categories below. For each instance found, record:

- **What happened**: Cite the specific moment (quote user messages or describe tool calls)
- **Category**: Which friction type (A–F)
- **Evidence**: What makes this friction rather than normal workflow

### Friction Taxonomy

#### A. Missing Context
Claude didn't know something it should have.

Detection heuristics:
- Claude asked a question answerable by project docs ("What test framework?", "Where's the config?")
- User provided factual project info Claude should have known ("We use pnpm not npm", "The API is in /services")
- Claude assumed wrong and was corrected
- Signal phrases: "actually we use...", "no, it's in...", "we don't use X, we use Y"

Maps to: **CLAUDE.md addition** (primary), memory update (secondary)

#### B. Missing Tooling
A task needed a tool or integration that wasn't available.

Detection heuristics:
- User did something manually that a tool could automate ("I'll check that in the browser")
- Claude stated it couldn't access something ("I don't have access to your database")
- User copy-pasted data from an external source
- Signal phrases: "I wish you could...", "can you access...", "let me paste this from..."

Maps to: **MCP server suggestion** (primary), skill creation (secondary)

#### C. Repeated Patterns
Same multi-step workflow executed multiple times.

Detection heuristics:
- Near-duplicate user instructions within or across sessions
- User described a workflow verbosely that could be a slash command
- Claude performed the same tool sequence multiple times with minor variations

Maps to: **Skill/slash command creation** (primary), hook (secondary)

#### D. Failed Attempts
Backtracking, errors, and retries.

Detection heuristics:
- Bash commands with non-zero exit codes followed by retries
- Edit operations immediately followed by another edit to the same file
- Test failures followed by fix and re-run cycles
- 3+ file reads in quick succession to different files (searching for the right one)

Maps to: **CLAUDE.md gotcha/warning** (primary), hook for pre-validation (secondary)

#### E. User Corrections
Explicit or implicit redirection by the user.

Detection heuristics:
- Messages starting with negation: "No,", "Actually,", "I meant...", "Not that..."
- User reverting or undoing Claude's work
- User rephrasing a request more precisely after misunderstanding
- Signal phrases: "that's not what I asked", "let me clarify", "I said X not Y"

Maps to: **CLAUDE.md instruction** (primary), memory update (secondary)

#### F. Exploration Overhead
Excessive searching before productive action.

Detection heuristics:
- 5+ Glob/Grep/Read calls before first meaningful Edit/Write
- Claude asking "which file should I look at?"
- Very high read:write ratio, especially at task start

Maps to: **CLAUDE.md architecture/structure section** (primary), skill with file pointers (secondary)

### Important: What Is NOT Friction

- Normal exploratory reads at the start of a new task in an unfamiliar codebase
- Discussion or planning before implementation (this is good practice)
- User changing their mind about requirements (not a correction — it's iteration)
- Hypothetical discussions about problems (don't treat "what if X broke" as actual friction)

## Phase 3: (Optional) Scan Past Sessions

Only do this if the user explicitly requests it OR if the current session yielded fewer than 3 suggestions.

1. Find recent `.jsonl` transcripts: `ls -t ~/.claude/projects/*/` and look for `.jsonl` files
2. For the 3 most recent transcripts, extract only user messages (first 200 chars each)
3. Look for cross-session patterns — these are the highest-value findings
4. Budget: max 3–4 tool calls per past session. Stop after 5+ total suggestions.

## Phase 4: Deduplicate and Filter

Remove suggestions that are:
- Already covered by existing CLAUDE.md content (from Phase 1 inventory)
- Already addressed by an installed skill, hook, or MCP server
- Generic advice not grounded in a specific observed conversation moment
- Hypothetical rather than evidence-based

**Every remaining suggestion MUST cite a specific conversation moment.** If you cannot point to where the friction occurred, discard the suggestion.

## Phase 5: Assign Confidence and Rank

Assign confidence to each suggestion:

- **High**: Direct user correction, explicit statement of need, or repeated pattern (3+ occurrences)
- **Medium**: Inferred from behavior patterns (failed attempts, excessive exploration)
- **Low**: Single occurrence that might be a one-off

Sort: high confidence first, then by estimated impact. Cap at **7–8 suggestions maximum**. Quality over quantity.

## Phase 6: Present Report

Use this exact output format:

```
# Session Reflection Report

**Session summary**: [1-2 sentences on what was accomplished]
**Friction instances found**: N (H high / M medium / L low confidence)

---

### 1. [Short Title]

**Category**: [Missing Context | Missing Tooling | Repeated Pattern | Failed Attempt | User Correction | Exploration Overhead]
**Confidence**: [High | Medium | Low]
**What happened**: [1-2 sentences citing the specific moment]

**Suggested remedy** — [CLAUDE.md | Skill | MCP Server | Memory | Hook]:
```[diff or yaml or shell command as appropriate]
[concrete draft content ready to apply]
```

---

[Repeat for each suggestion, numbered sequentially]

---

*No files have been modified. Which suggestions would you like to apply?*
```

## Edge Cases

- **Very short session** (< 5 user messages): Note that running at end-of-session yields better results. Still analyze what's available, but mention the limitation.
- **Clean session** (no friction found): Say so honestly. Don't manufacture suggestions. Optionally offer to scan past sessions for patterns.
- **Brand new user** (no CLAUDE.md, no skills): The first suggestion should be creating a CLAUDE.md with a starter template based on what was observed in the conversation.
- **One-time accidents**: Include but mark as Low confidence with a note that it may be a one-off.

## Relationship to Other Skills

When presenting suggestions, check if these skills are installed and reference them:

- **claude-md-improver**: If installed, note that your CLAUDE.md suggestions complement it (this skill is evidence-driven from conversation; that skill is quality-driven from documentation standards)
- **hookify / conversation-analyzer**: If installed, note that hook suggestions can be implemented via hookify
- **claude-automation-recommender**: If installed, note that it analyzes the codebase while this skill analyzes the conversation

## Applying Suggestions

When the user selects suggestions to apply:

- **CLAUDE.md additions**: Use the Edit tool to append to the appropriate CLAUDE.md file
- **Memory updates**: Use the Edit tool to update MEMORY.md
- **Skill suggestions**: Describe what the skill would do; offer to create the SKILL.md
- **MCP server suggestions**: Provide the install command (e.g., `claude mcp add ...`)
- **Hook suggestions**: Provide the hook configuration to add to settings

Always confirm before modifying any file. Show exactly what will change.
