# Migrating a machine from packer.nvim → lazy.nvim

This config has been migrated from **packer.nvim** to **lazy.nvim**. The lazy
setup lives on the **`lazy`** branch (the `main` branch still holds the old
packer config as a fallback).

Follow these steps on each machine that is still on packer.

> The config bootstraps lazy.nvim itself — see `lua/carub/lazy.lua`. You do
> **not** need to install any plugin manager by hand. Just clean out the old
> packer state and open Neovim.

---

## 0. Prerequisites

- **Neovim ≥ 0.9** (0.11+ recommended). Check with:
  ```sh
  nvim --version
  ```
  lazy.nvim and several plugins here will not work on older versions.
- `git`, a C compiler (for Treesitter parsers), and `nodejs`/`npm` if your
  LSPs need it (Mason installs most things automatically).

---

## 1. Back up the current state (so you can roll back)

The config repo lives at `~/.config/nvim`. The tracked files are safe in git,
but stash anything local and back up the runtime state dirs just in case:

```sh
cd ~/.config/nvim
git stash -u            # stash any uncommitted/untracked local changes (optional)

# Back up Neovim's runtime state (plugins, shada, cache) — not the config:
mv ~/.local/share/nvim ~/.local/share/nvim.packer.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak        2>/dev/null
mv ~/.cache/nvim       ~/.cache/nvim.bak              2>/dev/null
```

If you ever want to go back to packer: `git checkout main` and restore the
`*.bak` directories.

---

## 2. Pull the lazy config (switch to the `lazy` branch)

```sh
cd ~/.config/nvim
git fetch origin
git checkout lazy        # the branch with the lazy.nvim config
git pull --ff-only origin lazy
```

If `git checkout lazy` complains about local changes, you stashed them in
step 1 — it should be clean now. If the branch doesn't exist locally yet,
`git fetch origin` in the line above makes it available.

---

## 3. Remove leftover packer artifacts

Even after switching branches, a couple of packer leftovers can linger and
must be removed so lazy starts clean:

```sh
# packer-installed plugins (if the data dir wasn't moved in step 1)
rm -rf ~/.local/share/nvim/site/pack/packer

# packer's compiled file, if it exists in the config dir (it's gitignored)
rm -f ~/.config/nvim/plugin/packer_compiled.lua
```

> Note: `lua/carub/packer.lua` and `after/plugin.bak/` still exist on the
> branch but are **never loaded** by `init.lua`, so they're harmless. Leave
> them or delete them later — your call.

---

## 4. First launch (lazy bootstraps itself)

```sh
nvim
```

On the first start:
1. `lua/carub/lazy.lua` clones lazy.nvim into
   `~/.local/share/nvim/lazy/lazy.nvim`.
2. lazy reads every spec under `lua/plugins/` and installs them, pinned to the
   versions in **`lazy-lock.json`**.
3. **Mason** (via `lua/plugins/lsp.lua`) installs your LSP servers.
4. **Treesitter** (via `lua/plugins/treesitter.lua`) compiles parsers.

You'll see the lazy UI install everything. If it doesn't auto-open or
something looks incomplete, run inside Neovim:

```vim
:Lazy sync       " install/clean/update to match lazy-lock.json
:Lazy restore    " force-install the exact pinned versions from lazy-lock.json
```

---

## 5. Verify

Inside Neovim:

```vim
:Lazy            " all plugins should show as installed (no errors)
:Mason           " LSP servers installed
:checkhealth     " resolve any reported issues (compiler, node, etc.)
```

Open a Clojure/Lua file and confirm LSP, Treesitter highlighting, and your
keymaps work.

---

## Keeping machines in sync afterwards

All machines stay on the `lazy` branch. To pull new config changes later:

```sh
cd ~/.config/nvim
git pull --ff-only origin lazy
nvim +"Lazy sync" +qa     # apply plugin changes headlessly (optional)
```

Commit `lazy-lock.json` whenever you update plugins so every machine installs
the same versions.

---

## Quick rollback to packer

```sh
cd ~/.config/nvim
git checkout main
rm -rf ~/.local/share/nvim/lazy
mv ~/.local/share/nvim.packer.bak ~/.local/share/nvim   # if you made the backup
nvim                                                    # let packer run :PackerSync
```
