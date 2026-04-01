# Neovim Plugin Manager Migration - Rollback Plans

This document contains rollback procedures for both lazy.nvim and native packages migrations.

---

## Current Setup: lazy.nvim

Your configuration is now using lazy.nvim with plugin specs in `lua/plugins/`.

---

## ROLLBACK: lazy.nvim → Packer

### Option 1: Git Branch Rollback (Recommended)

```bash
# Switch to backup branch with working Packer config
cd ~/.config/nvim
git checkout packer-backup

# Remove lazy.nvim data
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy

# Reinstall Packer (if needed)
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Launch and sync
nvim -c 'PackerSync'
```

### Option 2: Manual Restoration

If git branch doesn't work:

1. **Remove lazy.nvim loading**:
   ```lua
   -- In lua/carub/init.lua, remove:
   require("carub.lazy")

   -- And add:
   require("carub.packer")
   ```

2. **Clean up lazy.nvim**:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm -rf ~/.local/state/nvim/lazy
   rm -rf ~/.config/nvim/lua/plugins/
   rm ~/.config/nvim/lua/carub/lazy.lua
   ```

3. **Reinstall Packer**:
   ```bash
   git clone --depth 1 https://github.com/wbthomason/packer.nvim \
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```

4. **Sync plugins**:
   ```vim
   :PackerSync
   ```

### Emergency: Neovim Won't Start

```bash
cd ~/.config/nvim
git checkout packer-backup
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
nvim -c 'PackerSync'
```

---

## ALTERNATIVE: Native Neovim Packages (Plan B)

If you want to migrate away from lazy.nvim to native packages instead of Packer:

### What Are Native Packages?

Neovim's built-in package system loads plugins from:
- `~/.local/share/nvim/site/pack/{name}/start/` (auto-load)
- `~/.local/share/nvim/site/pack/{name}/opt/` (manual via `:packadd`)

### Limitations
- No auto-install or auto-update
- No dependency resolution
- No lazy loading
- Manual git clone for each plugin
- Manual build steps

### Step 1: Create Install Script

Save as `~/.config/nvim/install-plugins.sh`:

```bash
#!/bin/bash
set -e

PACK_DIR="$HOME/.local/share/nvim/site/pack/plugins/start"

echo "Installing plugins to $PACK_DIR"
mkdir -p "$PACK_DIR"
cd "$PACK_DIR"

# Core dependency
git clone --depth 1 https://github.com/nvim-lua/plenary.nvim

# Fuzzy Finding
git clone --depth 1 https://github.com/nvim-telescope/telescope.nvim --branch 0.1.x
git clone --depth 1 https://github.com/nvim-telescope/telescope-fzf-native.nvim
(cd telescope-fzf-native.nvim && make)

# LSP
git clone --depth 1 https://github.com/VonHeikemen/lsp-zero.nvim --branch v4.x
git clone --depth 1 https://github.com/neovim/nvim-lspconfig
git clone --depth 1 https://github.com/williamboman/mason.nvim
git clone --depth 1 https://github.com/williamboman/mason-lspconfig.nvim

# Completion
git clone --depth 1 https://github.com/hrsh7th/nvim-cmp
git clone --depth 1 https://github.com/hrsh7th/cmp-nvim-lsp
git clone --depth 1 https://github.com/hrsh7th/cmp-buffer
git clone --depth 1 https://github.com/hrsh7th/cmp-path
git clone --depth 1 https://github.com/saadparwaiz1/cmp_luasnip
git clone --depth 1 https://github.com/hrsh7th/cmp-nvim-lua

# Snippets
git clone --depth 1 https://github.com/L3MON4D3/LuaSnip
git clone --depth 1 https://github.com/rafamadriz/friendly-snippets

# Treesitter
git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter
git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter-textobjects

# Git
git clone --depth 1 https://github.com/lewis6991/gitsigns.nvim
git clone --depth 1 https://github.com/ruifm/gitlinker.nvim
git clone --depth 1 https://github.com/tpope/vim-fugitive

# Navigation
git clone --depth 1 https://github.com/theprimeagen/harpoon
git clone --depth 1 https://github.com/nvim-tree/nvim-tree.lua
git clone --depth 1 https://github.com/christoomey/vim-tmux-navigator

# UI
git clone --depth 1 https://github.com/nvim-lualine/lualine.nvim
git clone --depth 1 https://github.com/JoosepAlviste/palenightfall.nvim
git clone --depth 1 https://github.com/nvim-tree/nvim-web-devicons

# Utilities
git clone --depth 1 https://github.com/numToStr/Comment.nvim
git clone --depth 1 https://github.com/ixru/nvim-markdown

# AI
git clone --depth 1 https://github.com/zbirenbaum/copilot.lua

# Clojure
git clone --depth 1 https://github.com/Olical/conjure

echo "All plugins installed!"
echo "Run ':TSUpdate' in Neovim to install treesitter parsers"
```

### Step 2: Create Update Script

Save as `~/.config/nvim/update-plugins.sh`:

```bash
#!/bin/bash
PACK_DIR="$HOME/.local/share/nvim/site/pack/plugins/start"

echo "Updating all plugins..."
for dir in "$PACK_DIR"/*/; do
    if [ -d "$dir/.git" ]; then
        echo "Updating $(basename "$dir")..."
        (cd "$dir" && git pull --ff-only)
    fi
done

# Rebuild telescope-fzf-native
echo "Rebuilding telescope-fzf-native..."
(cd "$PACK_DIR/telescope-fzf-native.nvim" && make clean && make)

echo "Done! Run ':TSUpdate' in Neovim to update parsers"
```

### Step 3: Migrate from lazy.nvim to Native Packages

```bash
# 1. Remove lazy.nvim
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy

# 2. Remove lazy.nvim loading from init
# Edit lua/carub/init.lua and remove: require("carub.lazy")

# 3. Run install script
chmod +x ~/.config/nvim/install-plugins.sh
~/.config/nvim/install-plugins.sh

# 4. Create after/plugin configs (copy from lua/plugins/ files)
# The config functions need to be in after/plugin/*.lua files

# 5. Start Neovim and update treesitter
nvim -c ':TSUpdate'
```

### Step 4: After/Plugin Configs for Native Packages

With native packages, you need `after/plugin/` files for configuration.
Your existing `after/plugin/` backup can be restored, or create new ones
based on the `config` functions in your `lua/plugins/` files.

### Rollback: Native Packages → Packer

```bash
# Remove native packages
rm -rf ~/.local/share/nvim/site/pack/plugins

# Switch to packer-backup
cd ~/.config/nvim
git checkout packer-backup

# Reinstall Packer and sync
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim -c 'PackerSync'
```

---

## Quick Reference: What Gets Reset

| Item | Preserved | Reinstalled |
|------|-----------|-------------|
| Keymaps | Yes | - |
| Settings | Yes | - |
| Plugin configs | Yes | - |
| Plugins | - | Yes |
| LSP servers | - | Via Mason |
| Treesitter parsers | - | Via :TSUpdate |

---

## Branch Reference

- `main` or `lazy-migration`: Current lazy.nvim setup
- `packer-backup`: Working Packer configuration
