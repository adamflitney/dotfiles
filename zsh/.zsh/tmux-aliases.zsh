# ========================================
# Tmux Project Management
# ========================================

export TMUXINATOR_CONFIG="$HOME/.config/tmuxinator"

# Aliases (tm and tmn are in ~/.local/bin via PATH)
alias tml='tmuxinator list'
alias tms='tmux list-sessions'
alias tma='tmux attach-session -t'
alias tmk='tmux kill-session -t'

# Completions for tm command (project names)
if type compdef &>/dev/null; then
  _tm_completion() {
    local projects=($(tmuxinator list -n 2>/dev/null | tail -n +2))
    _describe 'project' projects
  }
  compdef _tm_completion tm
fi
