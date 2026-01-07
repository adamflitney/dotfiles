# OpenCode Configuration

Global OpenCode configuration files.

## Files

- `AGENTS.md` - Custom instructions for OpenCode with automatic plan persistence
- `opencode.json` - OpenCode configuration

## Installation

Symlink these files to `~/.config/opencode/`:

```bash
mkdir -p ~/.config/opencode
ln -sf ~/dotfiles/opencode/AGENTS.md ~/.config/opencode/AGENTS.md
ln -sf ~/dotfiles/opencode/opencode.json ~/.config/opencode/opencode.json
```

## Plan Persistence

The `AGENTS.md` file includes rules to automatically:
- Create `.opencode/plan.md` files for complex tasks
- Update plans as work progresses
- Resume from saved plans after context compaction

This ensures OpenCode can always pick up where it left off.
