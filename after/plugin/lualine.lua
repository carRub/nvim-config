-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight-night',
    -- theme = 'dracula',
    component_separators = '|',
    section_separators = '',
  },
}
