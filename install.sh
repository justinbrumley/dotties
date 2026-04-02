#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    print_error "This script is designed for Arch Linux only!"
    exit 1
fi

print_info "Starting dotfiles installation for Arch Linux..."
echo ""

# Update system
print_info "Updating system packages..."
sudo pacman -Syu --noconfirm
print_success "System updated"
echo ""

# Install required packages
print_info "Installing required packages..."
REQUIRED_PACKAGES=(
    "sway"
    "waybar"
    "kitty"
    "neovim"
    "zsh"
    "fzf"
    "stow"
    "git"
    "jq"                    # Required by swayworkspace script
    "ripgrep"               # For fast searching
    "eza"                   # Modern ls replacement
    "grim"                  # Screenshot utility
    "slurp"                 # Screen area selection
    "wl-clipboard"          # Wayland clipboard utilities
    "clipman"               # Clipboard manager
    "network-manager-applet" # nm-applet
    "python"                # For waybar scripts
    "python-pip"
    "playerctl"             # Media player control
)

for package in "${REQUIRED_PACKAGES[@]}"; do
    if pacman -Qi "$package" &> /dev/null; then
        print_info "$package is already installed"
    else
        print_info "Installing $package..."
        sudo pacman -S --noconfirm "$package"
        print_success "$package installed"
    fi
done
echo ""

# Install optional packages
print_info "Installing optional packages..."
OPTIONAL_PACKAGES=(
    "firefox"               # Browser
    "nodejs"                # For various nvim plugins
    "npm"
    "go"                    # Go language
    "rust"                  # Rust language
    "cargo"
    "docker"
    "docker-compose"
    "tmux"
    "tree-sitter"           # For nvim treesitter
    "tree-sitter-cli"
)

for package in "${OPTIONAL_PACKAGES[@]}"; do
    if pacman -Qi "$package" &> /dev/null; then
        print_info "$package is already installed"
    else
        read -p "Install optional package $package? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            sudo pacman -S --noconfirm "$package"
            print_success "$package installed"
        fi
    fi
done
echo ""

# Check for AUR helper (yay or paru)
print_info "Checking for AUR helper..."
AUR_HELPER=""
if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
    print_success "Found yay"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
    print_success "Found paru"
else
    print_warning "No AUR helper found (yay/paru)"
    read -p "Install yay AUR helper? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installing yay..."
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd -
        AUR_HELPER="yay"
        print_success "yay installed"
    fi
fi
echo ""

# Install AUR packages if AUR helper is available
if [ -n "$AUR_HELPER" ]; then
    print_info "Installing AUR packages..."
    AUR_PACKAGES=(
        "oh-my-zsh-git"
        "zsh-vi-mode"
        "wofi"              # Application launcher (if using)
    )
    
    for package in "${AUR_PACKAGES[@]}"; do
        if pacman -Qi "$package" &> /dev/null; then
            print_info "$package is already installed"
        else
            print_info "Installing $package from AUR..."
            $AUR_HELPER -S --noconfirm "$package" || print_warning "Failed to install $package"
        fi
    done
    echo ""
fi

# Setup oh-my-zsh if not installed via AUR
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "oh-my-zsh installed"
else
    print_info "oh-my-zsh already installed"
fi
echo ""

# Install zsh-vi-mode plugin if not available
ZSH_VI_MODE_DIR="/usr/share/zsh/plugins/zsh-vi-mode"
if [ ! -d "$ZSH_VI_MODE_DIR" ]; then
    print_warning "zsh-vi-mode not found in system directories"
    print_info "You may need to install it manually or via AUR"
fi

# Setup Vim Vundle
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    print_info "Installing Vundle for Vim..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    print_success "Vundle installed"
else
    print_info "Vundle already installed"
fi
echo ""

# Setup NVM (Node Version Manager)
if [ ! -d "$HOME/.config/nvm" ]; then
    read -p "Install NVM (Node Version Manager)? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installing NVM..."
        mkdir -p "$HOME/.config/nvm"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        export NVM_DIR="$HOME/.config/nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        print_success "NVM installed"
    fi
else
    print_info "NVM already installed"
fi
echo ""

# Install Neovim lazy.nvim plugin manager
print_info "Neovim plugins will be installed automatically on first launch via lazy.nvim"
echo ""

# Setup FZF
if [ ! -f "$HOME/.fzf.zsh" ]; then
    print_info "Setting up FZF..."
    /usr/bin/fzf --zsh > ~/.fzf.zsh 2>/dev/null || true
    print_success "FZF configured"
else
    print_info "FZF already configured"
fi
echo ""

# Create necessary directories
print_info "Creating necessary directories..."
mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.tmp
mkdir -p ~/Pictures/screenshots
mkdir -p ~/Pictures/gowall
print_success "Directories created"
echo ""

# Stow dotfiles
print_info "Ready to stow dotfiles..."
read -p "Stow all dotfiles now? This will create symlinks in your home directory. [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_info "Stowing dotfiles..."
    
    # Check for conflicts
    CONFLICTS=$(stow -n . 2>&1 | grep "existing target" || true)
    if [ -n "$CONFLICTS" ]; then
        print_warning "Conflicts detected:"
        echo "$CONFLICTS"
        read -p "Backup existing files and continue? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
            mkdir -p "$BACKUP_DIR"
            print_info "Backing up existing files to $BACKUP_DIR..."
            
            # Move conflicting files to backup
            echo "$CONFLICTS" | grep "existing target" | sed 's/.*existing target is //' | while read -r file; do
                if [ -e "$file" ]; then
                    mkdir -p "$BACKUP_DIR/$(dirname "${file#$HOME/}")"
                    mv "$file" "$BACKUP_DIR/$(dirname "${file#$HOME/}")"
                fi
            done
            print_success "Files backed up"
        else
            print_warning "Skipping stow. You can manually run 'stow .' later"
            exit 0
        fi
    fi
    
    stow .
    print_success "Dotfiles stowed successfully!"
else
    print_info "Skipping stow. You can manually run 'stow .' later"
fi
echo ""

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    read -p "Change default shell to zsh? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Changing default shell to zsh..."
        chsh -s $(which zsh)
        print_success "Default shell changed to zsh"
        print_warning "You'll need to log out and back in for this to take effect"
    fi
else
    print_info "Default shell is already zsh"
fi
echo ""

# Post-installation instructions
print_success "Installation complete!"
echo ""
print_info "Post-installation steps:"
echo "  1. Set DEEPSEEK_API_KEY environment variable if using codecompanion"
echo "  2. Adjust output names in ~/.config/sway/config to match your monitors"
echo "  3. Run 'vim +PluginInstall +qall' to install Vim plugins"
echo "  4. Launch neovim to auto-install plugins via lazy.nvim"
echo "  5. Log out and log back in to start using sway"
echo "  6. Optional: Install 'insync' and 'vicinae' if needed"
echo ""
print_info "To start sway, run: sway"
echo ""
