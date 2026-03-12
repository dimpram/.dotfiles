#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ENV
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim

# COMMANDS
lfcd () {
    tmp="$(mktemp)"
    # `command` ensures we call the binary, not the function recursively
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            cd "$dir"
        fi
    fi
}

# ALIASES
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -lah'
alias grep='grep --color=auto'
alias lf=lfcd
alias vim=nvim
alias notes="firefox https://app.standardnotes.com/"

# PROMPT
PS1='[\u@\h \W]\$ '
