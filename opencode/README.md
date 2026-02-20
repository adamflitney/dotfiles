# OpenCode Configuration

Global OpenCode configuration files.

## Files

- `AGENTS.md` - Custom instructions for OpenCode with automatic plan persistence
- `opencode.json` - OpenCode configuration
- `agents/` - Custom agent definitions

## Installation

Symlink these files to `~/.config/opencode/`:

```bash
mkdir -p ~/.config/opencode
ln -sf ~/dotfiles/opencode/AGENTS.md ~/.config/opencode/AGENTS.md
ln -sf ~/dotfiles/opencode/opencode.json ~/.config/opencode/opencode.json
ln -sf ~/dotfiles/opencode/agents ~/.config/opencode/agents
```

## Custom Agents

The `agents/` directory contains custom agent modes that change how OpenCode behaves:

### Socratic (`@socratic`)

A discussion partner that guides you through problems using the Socratic method. Instead of giving direct answers, it asks clarifying questions to help you discover solutions yourself.

**Use when:** You want to deeply understand a problem or learn by working through it yourself.

**Invocation:** Start your message with `@socratic` to activate this agent.

**Features:**
- Read-only access (can read files and fetch docs, but won't make changes)
- Asks questions like "What are you trying to achieve?" and "What have you tried?"
- Gives hints, not answers
- Helps build your problem-solving skills

### Sensei (`@sensei`)

A teaching mode that explains concepts, techniques, and tools you need to implement something - without implementing it for you.

**Use when:** You have a plan and want to understand the underlying concepts before coding.

**Invocation:** Start your message with `@sensei` to activate this agent.

**Features:**
- Read-only access (can read files and fetch docs, but won't make changes)
- Creates targeted tutorials with "What/Why/How/Gotchas" format
- Uses analogies and simplified examples
- Builds understanding progressively
- Goal: teach you to fish, not fish for you

## Plan Persistence

The `AGENTS.md` file includes rules to automatically:
- Create `.opencode/plan.md` files for complex tasks
- Update plans as work progresses
- Resume from saved plans after context compaction

This ensures OpenCode can always pick up where it left off.
