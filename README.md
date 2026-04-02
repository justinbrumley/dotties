# Dotfiles

Personal configuration files for sway, nvim, vim, kitty, zsh, and waybar.

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

2. Use GNU Stow to symlink configurations:
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
