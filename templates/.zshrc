# Zplug configuration
export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

# Theme RobbyRussel
zplug "themes/robbyrussell", from:oh-my-zsh

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

# Zplug plugins
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/bundler", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/history-substring-search", from:oh-my-zsh
zplug "plugins/nanoc", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/rails", from:oh-my-zsh
zplug "plugins/ruby", from:oh-my-zsh
zplug "plugins/zeus", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install missing plugins
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi

# Load the plugins in the terminal
# Then, source plugins and add commands to $PATH
zplug load

# Rbenv configuration
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Nodenv configuration
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# Phantomenv configuration
export PATH="$HOME/.phantomenv/bin:$PATH"
eval "$(phantomenv init -)"

# Jenv configuration
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Mongod
# export PATH="$HOME/code/mongo/mongo-3.4.0/mongodb-osx-x86_64-3.4.0/bin:$PATH"

# Substring search
zmodload zsh/terminfo
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Disable spring
export DISABLE_SPRING=true

# History
# Share the terminal history. SAVEHIST is the number of lines to save, so set it really high.
export SAVEHIST=200000
export HISTFILE=~/.zsh_history
setopt inc_append_history
setopt share_history
