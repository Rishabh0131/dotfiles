# Set XDG config home (must be before ZINIT_HOME)
export XDG_CONFIG_HOME="$HOME/.config"

# Add user-global npm binaries to PATH
export PATH="$HOME/.npm-global/bin:$PATH"

# Add fuzzy find preview.sh file
export PATH="$HOME/.local/bin:$PATH"

# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source / Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

#Add in snippts
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

#To customize prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"

# KeyBindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='exa -l'
alias vi='nvim'


# Shell integrations
eval "$(fzf --zsh)"

export GIT_TERMINAL_PROMPT=1


# Load Angular CLI autocompletion.
source <(ng completion script)


# Fuzzy find preview alias
fzfp() {
  fzf --style full \
    --border --padding 1,2 \
    --border-label " Fuzzy Find " \
    --input-label " Input " \
    --header-label " File Type " \
    --preview "fzf-preview.sh {}" \
    --preview-window=right:60% \
    --bind "result:transform-list-label(
        if [[ -z \$FZF_QUERY ]]; then
          echo \" \$FZF_MATCH_COUNT items \"
        else
          echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"
        fi
    )" \
    --bind "focus:transform-preview-label(
        [[ -n {} ]] && printf \" Previewing [%s] \" {} || echo \" No selection \"
    )" \
    --bind "focus:transform-header(
        [[ -n {} ]] && file --brief {} || echo \" No file selected \"
    )" \
    --bind "ctrl-r:change-list-label( Reloading the list )+reload(sleep 0.3; git ls-files)" \
    --color "border:#aaaaaa,label:#cccccc" \
    --color "preview-border:#9999cc,preview-label:#ccccff" \
    --color "list-border:#669966,list-label:#99cc99" \
    --color "input-border:#996666,input-label:#ffcccc" \
    --color "header-border:#6699cc,header-label:#99ccff"
}

# Fuzzy find preview key binding 
bindkey -s '^f' 'fzfp\n'

# Opne fzy find in nvim alias
unalias vf 2>/dev/null
vf() {
  local file
  file=$(fzfp) || return
  nvim "$file"
}

