return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'VeryLazy',
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'palenight',
                    component_separators = '|',
                    section_separators = '',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { { 'filename', path = 4 } },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
            })
        end,
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
    },
}
