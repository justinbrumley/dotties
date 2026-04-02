export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="pygmalion"

# Load all the things (plugins)
plugins=(git golang doctl gcloud tmux heroku rust docker docker-compose)

# Transparent background support
export TERM=xterm-256color

# Default to using Bake with Docker Compose
export COMPOSE_BAKE=true

# Give zsh a little more oomph
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# Make things mean other things
alias vi="nvim"
alias ls="eza"
alias yolo="copilot --allow-all-tools --allow-all-paths"

# Everybody loves adding stuff to $PATH
export PATH=$PATH:~/.npm-global/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin

# Import colorscheme from pywal
if [ -d "$HOME/.cache/wal" ]; then
  cat $HOME/.cache/wal/sequences
fi

# Sane defaults for XDG vars
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Use console for inputting gpg passwords
export GPG_TTY=$(tty)

# nvm stuff
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
