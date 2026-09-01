# ==========================
# ZSH CONFIG
# ==========================

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colors
autoload -Uz colors && colors

# ==========================
# FZF
# ==========================

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Catppuccin Mocha FZF theme
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5c2e7,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5c2e7 \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --multi --layout=reverse --border=rounded \
  --prompt='  ' --pointer=' ' --marker='✓ '"

# ==========================
# EDITOR
# ==========================

export EDITOR=nvim
export VISUAL=nvim

# ==========================
# PATH
# ==========================

export PATH="$HOME/.local/bin:$PATH"

#
# ==========================
# PROMPT
# ==========================

# Catppuccin Mocha color codes (256-color approximations)
# Mauve=#cba6f7(135), Blue=#89b4fa(111), Green=#a6e3a1(114)
# Yellow=#f9e2af(222), Red=#f38ba8(211), Subtext=#bac2de(146)
# Overlay=#6c7086(60), Pink=#f5c2e7(218), Sky=#89dceb(117)

# Git info with status indicators
_ctp_git_info() {
  local branch dirty stash ahead behind
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  dirty=$(git status --porcelain 2>/dev/null | wc -l)
  stash=$(git stash list 2>/dev/null | wc -l)
  ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo 0)
  behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null || echo 0)

  local info="%F{218} %f%F{135}${branch}%f"
  (( dirty > 0 )) && info+=" %F{222}✦${dirty}%f"
  (( stash > 0 )) && info+=" %F{117}⚑${stash}%f"
  (( ahead > 0 )) && info+=" %F{114}⇡${ahead}%f"
  (( behind > 0 )) && info+=" %F{211}⇣${behind}%f"
  echo "$info"
}

# Exit code indicator
_ctp_exit_code() {
  local code=$?
  if (( code == 0 )); then
    echo "%F{114}❯%f"
  else
    echo "%F{211}❯%f"
  fi
}

setopt PROMPT_SUBST

# Top line: user@host | path | git
# Bottom line: arrow (green=ok, red=error)
PROMPT='%F{60}┌%f %F{111}%n%f%F{60)@%f%F{135}%m%f %F{60}in%f %F{114}%~%f$(_ctp_git_info)
%F{60}└%f$(_ctp_exit_code) '

RPROMPT='%F{60}%*%f'

# ==========================
# AUTOSUGGESTIONS
# ==========================

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==========================
# SYNTAX HIGHLIGHTING
# ==========================

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==========================
# KEYBINDS
# ==========================

#bindkey '^[[H' beginning-of-line
#bindkey '^[[F' end-of-line

# Ctrl+Backspace
#bindkey '^H' backward-kill-word

# ==========================
# WELCOME
# ==========================



# Added by Antigravity CLI installer
export PATH="/home/sarath/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
