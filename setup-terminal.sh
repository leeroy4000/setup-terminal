#!/bin/bash
set -e

echo "==> Installing packages..."
sudo apt update -q && sudo apt install -y zsh fzf git curl nano

echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "    Oh My Zsh already installed, skipping."
fi

echo "==> Installing zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

echo "==> Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "==> Writing ~/.zshrc..."
cat > ~/.zshrc << 'ZSHRC'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

# --- Aliases ---

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Listing
alias ll='ls -lah'
alias la='ls -A'
alias lf='ls -lah | grep'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick edits
alias zshrc='nano ~/.zshrc'
alias reload='source ~/.zshrc'

# System
alias update='sudo apt update && sudo apt upgrade -y'
alias ports='ss -tulnp'
alias myip='curl -s ifconfig.me && echo'
alias df='df -h'
alias free='free -h'

# Shortcuts
alias c='clear'
alias h='history'
alias q='exit'
ZSHRC

echo "==> Writing ~/.config/starship.toml..."
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'TOML'
format = "$username$hostname $directory$git_branch$git_status$character"

[username]
show_always = true
format = "[$user](bold yellow)@"

[hostname]
ssh_only = false
format = "[$hostname](bold cyan) "

[directory]
truncation_length = 3
truncate_to_repo = false

[character]
success_symbol = "[❯](green)"
error_symbol = "[❯](red)"
TOML

echo "==> Setting zsh as default shell..."
chsh -s "$(which zsh)"

echo ""
echo "Done! Open a new terminal or run: exec zsh"
