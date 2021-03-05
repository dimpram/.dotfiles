# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e

# # If not running interactively, don't do anything (Unix default)
# [[ $- != *i* ]] && return

# Options
setopt no_nomatch # For ignoring globbing expressions
zstyle :compinstall filename $HOME'/.zshrc'
autoload -Uz compinit
compinit

# PROMPT='2018149 > '

# Aliases
# Common
alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias grep='grep --color'
alias net='nmtui'
alias vim='nvim'

# Custom
alias scr='xrandr --output HDMI2 --mode 1920x1200 --left-of eDP1'
alias dots='cd $HOME/git/.dotfiles/ && ls -la && git status'
alias weather='curl wttr.in/CFU'
alias mntphone='simple-mtpfs --device 1 cell/'
alias rutc='cd $HOME/git/RUTC-Webpage && git status && code .'
alias notes='cd $HOME/dox/uni/notes'

# NVM Setup
declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")

load_nvm () {
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
done
