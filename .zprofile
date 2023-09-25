path=($HOME'/.local/bin' $path)                       # custom scripts loading
path+=("$HOME/tools/go/bin")
path+=("$HOME/.npm-global/bin")
path+=("/opt/cuda/bin")
path+=("$HOME/.yarn/bin")
export PATH

# Loading rbenv automatically
eval "$(rbenv init -)"

