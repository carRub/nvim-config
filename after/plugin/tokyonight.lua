require('tokyonight').setup({
	style = "storm",
	terminal_colors = true,
    CursorLine = {
        -- bg = "#2a2e3d"
        bg = "#222326"
    }
  })

--local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.grep_string, {})
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
--vim.keymap.set('n', '<leader>gf', function()
	--builtin.grep_string({ search = vim.fn.input("Grep > ") })
--end)

