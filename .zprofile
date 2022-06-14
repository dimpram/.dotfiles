path=($HOME'/.local/bin' $path)                       # custom scripts loading
path+=("$HOME/go/bin")
path+=("$HOME/.npm-global/bin")
path+=("/opt/cuda/bin")
export PATH

# Loading rbenv automatically
eval "$(rbenv init -)"
