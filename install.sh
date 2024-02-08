echo $HOME
if [ ! $SHELL=="zsh" ]; then chsh -s $(which zsh); fi
ln ~/.dotfiles/.zshrc ~/.zshrc
echo "SUCCESS: default shell now $SHELL and configured"
ln ~/.dotfiles/.tmux.conf ~/.tmux.conf
echo "SUCCESS: tmux configation complete"
