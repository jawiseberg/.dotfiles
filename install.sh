#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

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
    echo -e "${RED}[ERROR]${RESET} Package manager not supported.${RESET}"
    exit 1
fi

echo -e "${GREEN}[SUCCESS]${RESET} Detected package manager: $PKG_MANAGER${RESET}"

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo -e "${YELLOW}[WARN]${RESET} zsh not found. Installing...${RESET}"
    $UPDATE_CMD
    $INSTALL_CMD zsh
else
    echo -e "${GREEN}[OKAY]${RESET} zsh is already installed.${RESET}"
fi

# Set zsh as the default shell
if [ ! $SHELL == "zsh" ]; then
    chsh -s $(which zsh)
    echo -e "${GREEN}[SUCCESS]${RESET} default shell now zsh${RESET}"
else
    echo -e "${GREEN}OKAY:${RESET} zsh is already the default shell.${RESET}"
fi

# Check for oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}[WARN]${RESET} oh-my-zsh not found. Installing...${RESET}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${GREEN}[OKAY]${RESET} oh-my-zsh is already installed.${RESET}"
fi

# Check for neovim
if ! command -v nvim &> /dev/null; then
    echo -e "${YELLOW}[WARN]${RESET} neovim not found. Installing...${RESET}"
    $UPDATE_CMD
    $INSTALL_CMD neovim
else
    echo -e "${GREEN}[OKAY]${RESET} neovim is already installed.${RESET}"
fi

# Check for tmux
if ! command -v tmux &> /dev/null; then
    echo -e "${YELLOW}[WARN]${RESET} tmux not found. Installing...${RESET}"
    $UPDATE_CMD
    $INSTALL_CMD tmux
else
    echo -e "${GREEN}[OKAY]${RESET} tmux is already installed.${RESET}"
fi

# Create symbolic links for .zshrc and .tmux.conf
if [ -f ~/.dotfiles/.zshrc ]; then
    ln -sf ~/.dotfiles/.zshrc ~/.zshrc
    echo -e "${GREEN}[SUCCESS]${RESET} zsh configuration loaded${RESET}"
else
    echo -e "${RED}ERROR:${RESET} .zshrc not found in .dotfiles directory${RESET}"
fi

if [ -f ~/.dotfiles/.tmux.conf ]; then
    ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
    echo -e "${GREEN}[SUCCESS]${RESET} tmux configuration loaded${RESET}"
else
    echo -e "${RED}[ERROR]${RESET} .tmux.conf not found in .dotfiles directory${RESET}"
fi

# Create symbolic link for nvim folder
if [ -d ~/.dotfiles/nvim ]; then
    ln -sf ~/.dotfiles/nvim ~/.config/
    echo -e "${GREEN}[SUCCESS]${RESET} nvim configuration loaded${RESET}"
else
    echo -e "${RED}[ERROR]${RESET} nvim folder not found in .dotfiles directory${RESET}"
fi