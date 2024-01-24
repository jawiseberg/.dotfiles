export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(macos iterm2 tmux git brew aliases)

source $ZSH/oh-my-zsh.sh

alias vim="nvim -u ~/dot/nvim/init.lua"
alias nvim="nvim -u ~/dot/nvim/init.lua"
alias tmux="tmux -f ~/dot/.tmux.conf"
alias zshconfig="nvim ~/dot/.zshrc"
alias nvimconfig="nvim ~/dot/nvim/init.lua"
