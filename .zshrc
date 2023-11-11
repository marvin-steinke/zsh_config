# vars
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$PATH:$HOME/.scripts:$HOME/.miniconda3/bin:$HOME/.local/bin:$HOME/.local/go/bin"
export EXCLUSION="{node_modules,__pycache__,venv}"
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --glob '!$EXCLUSION'"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND="fd --type d --follow --exclude '$EXCLUSION' #| cut -c3-"
export LC_ALL=en_US.UTF-8

# plugins
plugins+=(git)
plugins+=(fzf-tab)
plugins+=(fzf)
plugins+=(zsh-vi-mode)

# theme and color
eval "$(dircolors $HOME/.themes/dircolors.gruvbox)"
ZSH_THEME="agnoster"
ZVM_VI_HIGHLIGHT_FOREGROUND=#ebdbb2
ZVM_VI_HIGHLIGHT_BACKGROUND=#81a2be

source $ZSH/oh-my-zsh.sh

# bindings
zvm_after_init() {
    bindkey ^f fzf-file-widget
    bindkey ^h fzf-history-widget
    bindkey ^j fzf-cd-widget
    source $ZSH/plugins/fzf-tab/fzf-tab.zsh
}
bindkey ^p up-line-or-search
bindkey ^n down-line-or-search

# functions & alias
function standalone() {
    (nohup $1 & disown) &>/dev/null || true
}
function open() {
    (nohup xdg-open $1 & disown) &>/dev/null || true
}
function pdfcompress() {
    gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 \
    -dPDFSETTINGS=/printer -dSubsetFonts=true \
    -dColorImageDownsampleType=/Bicubic -dColorImageResolution=144 \
    -dGrayImageResolution=144 -dMonoImageDownsampleType=/Bicubic \
    -sOutputFile=$1.compressed.pdf $1
}
function pdfappend() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer \
    -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$1 *.pdf
}
alias .="clear; eza -alh --no-user --group-directories-first"
function chpwd() { . }
alias ..="cd .."
alias usb="cd /run/media/marvin/"
alias d="cd $HOME/Downloads/"
alias vim="nvim"
alias untar="tar -xzvf"
alias rf="rm -rf"
# git
function git_config() {
    git config user.email "marvin.steinke@$1.de"
    git config user.name "marvin.steinke"
}
