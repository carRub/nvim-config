return {
    {
        'theprimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-u>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-i>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-o>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-p>", function() ui.nav_file(4) end)
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '<leader>fi', ':NvimTreeToggle<CR>', desc = 'Toggle file tree' },
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require('nvim-tree').setup({
                view = {
                    side = "right",
                },
            })
        end,
    },
    {
        'christoomey/vim-tmux-navigator',
        event = 'VeryLazy',
    },
}
