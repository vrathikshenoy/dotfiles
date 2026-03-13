# 🗂️ Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/) for a clean, reproducible Linux setup.

## 📦 What's Included

| Package   | Description                              | Config Path                     |
|-----------|------------------------------------------|---------------------------------|
| `ghostty` | [Ghostty](https://ghostty.org) terminal  | `~/.config/ghostty/config`      |
| `kitty`   | [Kitty](https://sw.kovidgoyal.net/kitty/) terminal | `~/.config/kitty/kitty.conf` |
| `p10k`    | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt theme | `~/.p10k.zsh` |
| `zsh`     | Zsh shell configuration                  | `~/.zshrc`                      |

---

## 🖥️ Terminal Emulators

### Ghostty

A GPU-accelerated terminal configured with:

- **Font** — JetBrainsMono Nerd Font (size 18)
- **Appearance** — Semi-transparent background (opacity 0.8), blur, dark theme, no window decorations, bar cursor
- **Tabs** — Bottom tab bar with compact styling
- **Keybindings** — `Super+B` leader key for tab management, splits, and vim-style (`hjkl`) split navigation
- **Color scheme** — Kitty default palette on black background

### Kitty

A feature-rich GPU terminal configured with:

- **Font** — JetBrainsMono Nerd Font (size 16)
- **Appearance** — Transparent background (opacity 0.7), blur, no window decorations
- **Tab bar** — Powerline-style slanted tabs
- **Keybindings** — Same `Super+B` leader key convention as Ghostty for consistent muscle memory
- **Splits** — `Super+B > \` for vertical, `Super+B > -` for horizontal, vim-style navigation

> Both terminals share the same keybinding scheme so you can switch between them seamlessly.

---

## 🐚 Zsh Configuration

The `.zshrc` is organized into clean sections and uses [**Zinit**](https://github.com/zdharma-continuum/zinit) as the plugin manager.

### Plugins

| Plugin | Purpose |
|--------|---------|
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Fast, customizable prompt |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like inline suggestions |
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Real-time command highlighting |
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | Fuzzy completion with fzf |
| [Oh My Zsh Git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git) | Git aliases and helpers |

### Dev Toolchain

| Tool | Usage |
|------|-------|
| **Pyenv** + **Conda** (Miniconda) | Python version & environment management |
| **NVM** (lazy-loaded) | Node.js version management |
| **Bun** | Fast JS runtime & package manager |
| **pnpm** | Efficient Node package manager |
| **Rust / Cargo** | Rust toolchain |
| **CUDA 12.6** | NVIDIA GPU development |
| **Neovim** | Editor (`vim` aliased to `nvim`) |
| **Zoxide** | Smarter `cd` with `z` |
| **Docker** | Container runtime |
| **GitHub CLI** | `gh-switch` function for multi-account auth |

### Notable Settings

- **Vi mode** enabled (`set -o vi`)
- **Ctrl+Space** / **Ctrl+F** to accept autosuggestions
- History — 10,000 lines, shared across sessions, deduped
- Global `.env` file auto-loaded from `~/.env`
- Chrome launched via Flatpak (`alias chrome`)

---

## 🚀 Setup

### Prerequisites

- **Zsh** as your default shell
- [**GNU Stow**](https://www.gnu.org/software/stow/) for symlink management
- A [**Nerd Font**](https://www.nerdfonts.com/) installed (JetBrainsMono Nerd Font recommended)

### Installation

```bash
# Clone the repo to your home directory
git clone https://github.com/vrathikshenoy/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Stow individual packages (creates symlinks to ~/)
stow zsh        # → ~/.zshrc
stow p10k       # → ~/.p10k.zsh
stow ghostty    # → ~/.config/ghostty/config
stow kitty      # → ~/.config/kitty/kitty.conf

# Or stow everything at once
stow */
```

### Post-Install

1. **Restart your shell** or run `source ~/.zshrc`
2. **Zinit** will auto-install on first launch and pull all plugins
3. **Powerlevel10k** — run `p10k configure` if you want to customize the prompt
4. Install the dev tools referenced in `.zshrc` as needed:
   ```bash
   # Pyenv
   curl https://pyenv.run | bash

   # NVM
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

   # Rust
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

   # Zoxide
   curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

   # Bun
   curl -fsSL https://bun.sh/install | bash
   ```

---

## 🔑 Keybinding Cheatsheet

All keybindings use the **`Super+B`** leader key (works in both Ghostty and Kitty):

| Keybinding        | Action               |
|-------------------|----------------------|
| `Super+B > c`     | New tab              |
| `Super+B > x`     | Close tab/surface    |
| `Super+B > 1–9`   | Go to tab 1–9        |
| `Super+B > n`     | New window           |
| `Super+B > \`     | Vertical split       |
| `Super+B > -`     | Horizontal split     |
| `Super+B > h/j/k/l` | Navigate splits (vim-style) |

---

## 📁 Directory Structure

```
dotfiles/
├── ghostty/
│   └── .config/ghostty/config
├── kitty/
│   └── .config/kitty/kitty.conf
├── p10k/
│   └── .p10k.zsh
├── zsh/
│   └── .zshrc
└── README.md
```
