# ========================================
# Oh My Zsh Configuration
# ========================================
export ZSH="$HOME/.oh-my-zsh"

# Theme disabled - using Starship instead
# ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ========================================
# Environment
# ========================================
export EDITOR='nvim'
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

# fnm (Node.js version manager)
eval "$(fnm env --use-on-cd)"

# ========================================
# Aliases
# ========================================

# AWS SSO
alias lt="export AWS_PROFILE=test && aws sso login && echo \"Logged into \$(aws configure list | awk '/profile/ {print toupper(\$2)}' | tail -n 1)\""
alias lp="export AWS_PROFILE=prod && aws sso login && echo \"Logged into \$(aws configure list | awk '/profile/ {print toupper(\$2)}' | tail -n 1)\""

# Zsh config
alias zedit="nvim ~/.zshrc"
alias zreload="source ~/.zshrc"

# OpenCode
alias oc="opencode"

# Dotfiles management
alias dots="git -C ~/dotfiles status"
alias dotd="git -C ~/dotfiles diff"
alias dotl="tail -20 ~/.local/share/dotfiles-sync.log"
alias dotsync="~/.local/bin/dotfiles-sync"

# ========================================
# Tmux
# ========================================
alias tms='tmux list-sessions'
alias tma='tmux attach-session -t'
alias tmk='tmux kill-session -t'

# ========================================
# Starship prompt (must be at end)
# ========================================
eval "$(starship init zsh)"
