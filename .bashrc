# If not running interactively, don't do anything (Unix default)
[[ $- != *i* ]] && return

# user variable
PS1='[\u@\h \W]\$ '

# Aliases
# - Common
alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias grep='grep --color'
alias net='nmtui'

# - Custom
alias 2monitors='xrandr --output HDMI2 --mode 1920x1200 --left-of eDP1'
alias dots='cd $HOME/.dotfiles/ && ls && git status'
alias weather='curl wttr.in/CFU'
alias phone='simple-mtpfs --device 1 cell/'