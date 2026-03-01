#
# ~/.bash_profile
#


[[ -f ~/.bashrc ]] && . ~/.bashrc


# Auto-start dwl on TTY1 only
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec ~/.local/bin/startw
fi
