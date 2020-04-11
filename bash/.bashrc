#
# ~/.bashrc
#

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
alias ls='ls --color=auto'
cdls(){ cd $* && ls; }
alias net='nmtui'
alias mc='cd /home/jim/Documents/ && java -jar Minecraft.jar'
alias dots='cdls /home/jim/.dotfiles/ && git status'
alias ekabapp='cdls /home/jim/Documents/Projects/ekab/EkabApp'
alias rutc='cdls /home/jim/Documents/Projects/rutc/RUTC/ && git status'
