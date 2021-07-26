path=($HOME'/.local/bin' $path)                       # custom scripts loading
path+=("$HOME/go/bin")
path+=("~/.npm-global/bin")
export PATH

# Loading rbenv automatically
eval "$(rbenv init -)"
