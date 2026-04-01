return {
    {
        'JoosepAlviste/palenightfall.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('palenightfall').setup({})
            vim.cmd.colorscheme('palenightfall')
        end,
    },
}
