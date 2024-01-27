# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# colours
autoload -U colors && colors
setopt autocd
setopt interactive_comments

# load aliases
[ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"

# history in cache dir
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
#
# Auto-completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# Include hidden files.
_comp_options+=(auto_menu)	# Show completion menu on a single tab press.

bindkey -v
export KEYTIMEOUT=1
#
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
#
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;
        viins|main) echo -ne '\e[5 q';;
    esac
}
zle -N zle-keymap-select
zle-line-init () {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# plugins
source "${PLUGINS_HOME}/fsh/fast-syntax-highlighting.plugin.zsh" # syntax highlighting
#source "${PLUGINS_HOME}/gitprompt/git-prompt.zsh" # prompt
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh" # fuzzy search
source "${PLUGINS_HOME}/powerlevel10k/powerlevel10k.zsh-theme" # prompt

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi
