#!/bin/bash

# Detect package manager
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
    UPDATE_CMD="sudo apt-get update"
    INSTALL_CMD="sudo apt-get install -y"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    UPDATE_CMD="sudo yum check-update"
    INSTALL_CMD="sudo yum install -y"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    UPDATE_CMD="sudo dnf check-update"
    INSTALL_CMD="sudo dnf install -y"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    UPDATE_CMD="sudo pacman -Sy"
    INSTALL_CMD="sudo pacman -S --noconfirm"
elif command -v brew &> /dev/null; then
    PKG_MANAGER="brew"
    UPDATE_CMD="brew update"
    INSTALL_CMD="brew install"
else
    echo "Package manager not supported."
    exit 1
fi

echo "Detected package manager: $PKG_MANAGER"

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "zsh not found. Installing..."
    $UPDATE_CMD
    $INSTALL_CMD zsh
else
    echo "zsh is already installed."
fi

# Set zsh as the default shell
if [ ! $SHELL == "zsh" ]; then
    chsh -s $(which zsh)
    echo "SUCCESS: default shell now zsh"
else
    echo "zsh is already the default shell."
fi

# Check for oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh not found. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh is already installed."
fi

# Check for neovim
if ! command -v nvim &> /dev/null; then
    echo "neovim not found. Installing..."
    $UPDATE_CMD
    $INSTALL_CMD neovim
else
    echo "neovim is already installed."
fi

# Check for tmux
if ! command -v tmux &> /dev/null; then
    echo "tmux not found. Installing..."
    $UPDATE_CMD
    $INSTALL_CMD tmux
else
    echo "tmux is already installed."
fi

# Create symbolic links for .zshrc and .tmux.conf
if [ -f ~/.dotfiles/.zshrc ]; then
    ln -sf ~/.dotfiles/.zshrc ~/.zshrc
    echo "SUCCESS: zsh configuration loaded"
else
    echo "ERROR: .zshrc not found in .dotfiles directory"
fi

if [ -f ~/.dotfiles/.tmux.conf ]; then
    ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
    echo "SUCCESS: tmux configuration complete"
else
    echo "ERROR: .tmux.conf not found in .dotfiles directory"
fi