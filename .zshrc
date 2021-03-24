#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Version:  0.1.16                                                 #
# Author:   Øyvind "Mr.Elendig" Heggstad <mrelendig@har-ikkje.net> #
# Modified by @diimpram
#------------------------------------------------------------------#

#-----------------------------
# Source some stuff
#-----------------------------
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#------------------------------
# Variables
#------------------------------
export BROWSER="firefox"
export EDITOR="nvim"
export PATH="${PATH}:${HOME}/bin:${HOME}/.cabal/bin"
# export GOPATH="$HOME/go"

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
bindkey -v
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

#------------------------------
# Alias stuff
#------------------------------
alias ls='ls --color=auto --group-directories-first'
alias l='ls -lh'
alias la='ls -ah'
alias lla='ls -lah'
alias grep='grep --color'
alias net='nmtui'
alias vim='nvim'
alias tree='tree -I 'node_modules' --dirsfirst'

# Custom
alias scr='xrandr --output HDMI2 --mode 1920x1200 --left-of eDP1'
alias dots='cd $HOME/git/.dotfiles/ && ls -la && git status'
alias weather='curl wttr.in/CFU'
alias mntphone='simple-mtpfs --device 1 cell/'
alias rutc='cd $HOME/git/RUTC-Webpage && git status && code .'
alias notes='cd $HOME/dox/uni/notes'
alias sql='sudo mysql -u root -p'

#------------------------------
# Shell Functions
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# -- NVM
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


# -- Python venv
function cd() {
  if [[ -d ./venv ]] ; then
    deactivate
  fi

  builtin cd $1

  if [[ -d ./venv ]] ; then
    . ./venv/bin/activate
  fi
}

#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist 
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

#------------------------------
# Prompt
#------------------------------
autoload -U colors zsh/terminfo
colors

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[white]}%}[%{${fg[green]}%}%s%{${fg[white]}%}]%{${fg[white]}%}[%{${fg[red]}%}%b%{${fg[white]}%}]%{$reset_color%}"

setopt prompt_subst

if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then 
  p_host='%F{yellow}%M%f'
else
  p_host='%F{none}%M%f'
fi

PS1=${(j::Q)${(Z:Cn:):-$'
  $(acpi | grep -o "[0-9]*%")%
  " "
  ${p_host}
  %F{white}%~%f
  %(!.%F{red}%#%f.%F{none}%#%f)
  " "
'}}

PS2=$'%_>'
RPROMPT=$'${vcs_info_msg_0_}'
#RPROMPT=\$vcs_info_msg_0_

# vim: set ts=2 sw=2 et:
