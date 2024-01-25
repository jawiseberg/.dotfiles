export ZSH="$HOME/dot/ohmyzsh"
ZSH_THEME="robbyrussell"

plugins=(tmux git aliases)

source $ZSH/oh-my-zsh.sh

alias nvim="nvim -u ~/dot/nvim/init.lua"
alias tmux="tmux -f ~/dot/.tmux.conf"
alias zshconfig="nvim ~/dot/.zshrc"
alias nvimconfig="nvim ~/dot/nvim/init.lua"
