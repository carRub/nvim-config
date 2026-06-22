return {
    {
        'numToStr/Comment.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'kylechui/nvim-surround',
        version = '*',
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup()
        end,
    },
    {
        'ixru/nvim-markdown',
        ft = 'markdown',
    },
}
