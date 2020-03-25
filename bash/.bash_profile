#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
