return {
   'vimwiki/vimwiki',
   init = function ()
      vim.g.vimwiki_map_prefix = '<leader>n'
      vim.g.vimwiki_list = {{path = '~/Personal/wiki', syntax = 'markdown', ext = '.md'}}
      vim.g.vimwiki_auto_header = 1
   end
}


