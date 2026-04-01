return {
    {
        'numToStr/Comment.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'ixru/nvim-markdown',
        ft = 'markdown',
    },
}
