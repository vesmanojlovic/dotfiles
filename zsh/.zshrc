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
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
# lf icons
export LF_ICONS="di=:ln=:ex=:fi=:*.ml=λ:*.mli=λ:*.styl=:*.scss=:*.py=:*.pyc=:*.pyd=:*.pyo=:*.php=:*.markdown=:*.md=:*.json=:*.js=:*.bmp=:*.gif=:*.ico=:*.jpeg=:*.jpg=:*.png=:*.svg=:*.svgz=:*.tga=:*.tiff=:*.xmb=:*.xcf=:*.xpm=:*.xspf=:*.xwd=:*.cr2=:*.dng=:*.3fr=:*.ari=:*.arw=:*.bay=:*.crw=:*.cr3=:*.cap=:*.data=:*.dcs=:*.dcr=:*drf=:*.eip=:*.erf=:*.fff=:*.gpr=:*.iiq=:*.k25=:*.kdc=:*.mdc=:.*mef=:*.mos=:.*.mrw=:.*.obm=:*.orf=:*.pef=:*.ptx=:*.pxn=:*.r3d=:*.raf=:*.raw=:*.rwl=:*.rw2=:*.rwz=:*.sr2=:*.srf=:*.srf=:*.srw=:*.tif=:*.x3f=:*.ejs=:*.htm=:*.html=:*.slim=:*.xml=:*.mustasche=:*.css=:*.less=:*.bat=:*.conf=:*.ini=:*.rc=:*.yml=:*.cfg=:*.rc=:*.rss=:*.coffee=:*.twig=:*.c++=:*.cc=:*.c=:*.cpp=:*.cxx=:*.c=:*.h=:*.hs=:*.lhs=:*.lua=:*.jl=:*.go=:*.ts=:*.db=:*.dump=:*.sql=:*.sln=:*.suo=:*.exe=:*.diff=:*.sum=:*.md5=:*.sha512=:*.scala=:*.java=:*.jar=:*.xul=:*.clj=:*.cljc=:*.pl=:*.pm=:*.t=:*.cljs=:*.edn=:*.rb=:*.fish=:*.sh=:*.bash=:*.dart=:*.f#=:*.fs=:*.fsi=:*.fsscript=:*.fsx=:*.rlib=:*.rs=:*.d=:*.erl=:*.hrl=:*.ai=:*.psb=:*.psd=:*.jsx=:*.vim=:*.vimrc=:*.aac=:*.anx=:*.asf=:*.au=:*.axa=:*.flac=:*.m2a=:*.m4a=:*.mid=:*.midi=:*.mp3=:*.mpc=:*.oga=:*.ogg=:*.ogx=:*.ra=:*.ram=:*.rm=:*.spx=:*.wav=:*.wma=:*.ac3=:*.avi=:*.flv=:*.mkv=:*.mov=:*.mov=:*.mp4=:*.mpeg=:*.mpg=:*.webm=:*.epub=:*.pdf=:*.fb2=:*.djvu=:*.7z=:*.apk=:*.bz2=:*.cab=:*.cpio=:*.deb=:*.gem=:*.gz=:*.gzip=:*.lh=:*.lzh=:*.lzma=:*.rar=:*.rpm=:*.tar=:*.tgz=:*.xz=:*.zip=:*.cbr=:*.cbz=:*.log=:*.doc=:*.docx=:*.adoc=:*.xls=:*.xls=:*.xlsmx=:*.pptx=:*.ppt=:*.Xdefaults=:*.Xresources=:*.bashprofile=:*.bash_profile=:*.bashrc=:*.dmrc=:*.d_store=:*.fasd=:*.gitconfig=:*.gitignore=:*.jack-settings=:*.mime.types=:*.nvidia-settings-rc=:*.pam_environment=:*.profile=:*.recently-used=:*.selected_editor=:*.xinitpurc=:*.zprofile=:*.yarnc=:*.snclirc=:*.tmux.conf=:*.urlview=:*.config=:*.ini=:*.user-dirs.dirs=:*.mimeapps.list=:*.offlineimaprc=:*.msmtprc=:*.Xauthority=:*.config=sub=:srt=:idx=:*.mbsyncrc=:*lfrc="
# Auto-completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# Include hidden files.
_comp_options+=(auto_menu)	# Show completion menu on a single tab press.
eval "$(register-python-argcomplete dx|sed 's/-o default//')"

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
source "${PLUGINS_HOME}/powerlevel10k/powerlevel10k.zsh-theme" # prompt
# source "${PLUGINS_HOME}/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh" # fuzzy search

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

export TERM=foot
source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
