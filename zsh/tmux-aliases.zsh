# ========================================
# Tmux Project Management
# ========================================

export EDITOR='nvim'
export TMUXINATOR_CONFIG="$HOME/.config/tmuxinator"

# Add dotfiles scripts to PATH
export PATH="$HOME/dotfiles/scripts:$PATH"

# Aliases for tmux project management
alias tm='$HOME/dotfiles/scripts/tm'
alias tmn='$HOME/dotfiles/scripts/tmn'
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
