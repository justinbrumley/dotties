# Dotfiles

Personal configuration files for sway, nvim, vim, kitty, zsh, and waybar.

<img width="1920" height="1080" alt="20260511_11h16m56s_grim" src="https://github.com/user-attachments/assets/c6be5f47-cf15-42a0-bb5b-2db92f41ade4" />

## Structure

This repository is organized for use with [GNU Stow](https://www.gnu.org/software/stow/).

```
.
├── .config/
│   ├── kitty/          # Kitty terminal configuration
│   ├── nvim/           # Neovim configuration (lazy.nvim based)
│   ├── sway/           # Sway window manager configuration
│   └── waybar/         # Waybar status bar configuration
├── .local/
│   └── bin/
│       ├── dotenv      # Environment variable loader script
│       └── swayworkspace  # Custom sway workspace navigation script
├── .vimrc              # Vim configuration
└── .zshrc              # Zsh shell configuration
```

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url> ~/dotties
   cd ~/dotties
   ```

2. Run the installation script (Arch Linux only):
   ```bash
   ./install.sh
   ```

   The script will:
   - Update system packages
   - Install required dependencies (sway, waybar, kitty, neovim, zsh, etc.)
   - Optionally install AUR packages via yay/paru
   - Setup oh-my-zsh and other tools
   - Offer to stow the dotfiles automatically
   - Optionally change your default shell to zsh

3. Or manually use GNU Stow to symlink configurations:
   ```bash
   stow .
   ```

   Or selectively stow individual configs:
   ```bash
   stow -t ~ .config
   stow -t ~ .local
   stow -t ~ .vimrc .zshrc
   ```

## Dependencies

### Required

- sway
- waybar
- kitty
- neovim (with lazy.nvim plugin manager)
- zsh (with oh-my-zsh)
- fzf

### Optional

- eza (modern ls replacement)
- ripgrep (for fast searching)
- grim & slurp (for screenshots)
- nm-applet (network manager)
- insync
- vicinae

### Neovim Plugins

Managed by lazy.nvim. See `.config/nvim/lua/plugins/` for full list.
