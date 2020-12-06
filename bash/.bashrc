# If not running interactively, don't do anything
[[ $- != *i* ]] && return


###########
# user-id #
###########
PS1='[\u@\h \W]\$ '


#########
# Pywal #
#########
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh


###########
# Aliases #
###########
# Common
alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias grep='grep --color'
alias net='nmtui'

# Custom
alias scr='xrandr --output HDMI2 --mode 1920x1200 --left-of eDP1'
alias mc='cd $HOME/dox/ && java -jar Minecraft.jar'
alias dots='cd $HOME/.dotfiles/ && ls && git status'
alias ekabcms='cd /srv/http/AED-locator-cms && ls && git status && code .'
alias app='cd $HOME/proj/AED-locator-webpage && ls && git status && code .'
alias biotech='cd $HOME/proj/biotech && lla'
alias rutc='cd $HOME/proj/rutc/RUTC/ && ls && git status && code .'
alias job='cd $HOME/dox/job/biotech && lla'
alias weather='curl wttr.in/CFU'
