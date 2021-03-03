# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename $HOME'/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# # If not running interactively, don't do anything (Unix default)
[[ $- != *i* ]] && return

# For rbenv
eval "$(rbenv init -)"

# Options
setopt no_nomatch

# PROMPT='2018149 > '

# Aliases
# Common
alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias grep='grep --color'
alias net='nmtui'

# Custom
alias scr='xrandr --output HDMI2 --mode 1920x1200 --left-of eDP1'
alias dots='cd $HOME/git/.dotfiles/ && ls -la && git status'
alias weather='curl wttr.in/CFU'
alias mntphone='simple-mtpfs --device 1 cell/'
alias rutc='cd $HOME/git/RUTC-Webpage && git status && code .'
alias notes='cd $HOME/dox/uni/notes && code .'

# nvm loading
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# custom scripts loading
path=($HOME'/.local/bin' $path)
export PATH
