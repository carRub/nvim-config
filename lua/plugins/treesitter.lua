return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        config = function()
            -- New API: nvim-treesitter 1.0+
            -- Just handles parser installation, highlighting is built into Neovim
            require('nvim-treesitter').setup({})

            -- Install parsers
            local parsers = {
                "c", "javascript", "typescript", "go", "rust",
                "lua", "vim", "vimdoc", "markdown", "markdown_inline", "bash", "clojure"
            }

            -- Ensure parsers are installed
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    local install = require('nvim-treesitter.install')
                    for _, parser in ipairs(parsers) do
                        if not pcall(vim.treesitter.language.inspect, parser) then
                            install.install(parser)
                        end
                    end
                end,
                once = true,
            })

            -- Enable treesitter highlighting (built-in)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
}
