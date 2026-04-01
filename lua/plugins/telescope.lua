return {
    {
        'nvim-lua/plenary.nvim',
        lazy = false,
        priority = 1000,
    },
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({})

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>km', builtin.keymaps, {})
            vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
            vim.keymap.set('n', '<leader>rf', builtin.lsp_references, {})
            vim.keymap.set('n', '<leader>gs', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable('make') == 1
        end,
    },
}
