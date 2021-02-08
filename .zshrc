# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jim/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# # If not running interactively, don't do anything (Unix default)
[[ $- != *i* ]] && return

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
alias dots='cd $HOME/.dotfiles/ && ls && git status'
alias weather='curl wttr.in/CFU'
alias mntphone='simple-mtpfs --device 1 cell/'

