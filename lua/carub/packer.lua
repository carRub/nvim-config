-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use ({
	  'nvim-telescope/telescope-fzf-native.nvim',
	  run = "make"
  })

  use { -- Fuzzy finder
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ({ -- colorscheme
	  'folke/tokyonight.nvim',
	  as = 'tokyonight',
	  run = function()
		  print("Hello from colorscheme")
	  end,
	  config = function()
		  vim.cmd('colorscheme tokyonight')
	  end

  })

  -- use 'drewtempelmeyer/palenight.vim'

  use { -- Highlight, edit, and navigate code
	  'nvim-treesitter/nvim-treesitter',
	  run = function()
		  pcall(require('nvim-treesitter.install').update { with_sync = true })
	  end,
  }

  use { -- Additional text objects via treesitter
	  'nvim-treesitter/nvim-treesitter-textobjects',
	  after = 'nvim-treesitter',
  }

  use('theprimeagen/harpoon')

  use { -- LSP config
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }

  use ('nvim-lualine/lualine.nvim') -- Fancier statusline

  use ('nvim-tree/nvim-tree.lua') -- VScode like tree file explorer

  use ('Decodetalkers/csv-tools.lua') -- CSV file usage

  use {
      'lewis6991/gitsigns.nvim',
      config = function()
          require('gitsigns').setup()
      end
  }

end)
