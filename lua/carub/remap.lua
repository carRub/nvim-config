vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap -- for conciseness
-- Open netrw
-- keymap.set("n", "<leader>ep", vim.cmd.Ex)

-- Move highlighted lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- C-u (now C-a) and C-d keeping cursor at the middle of the page
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-a>", "<C-u>zz")
keymap.set("n", "<C-m>", "<C-o>") -- Jump to previous in jump list
keymap.set("n", "<C-n>", "<C-i>") -- Jump to next in jump list
--keymap.set("n", "<C-@>", "<C-Space>")

keymap.set("n", "<C-s>", "<C-e>") -- Scroll down

-- Keep searchterms in the middle of the page
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Yank to system clipboard keymap
keymap.set("n", "<leader>y", "\"+y")
keymap.set("v", "<leader>y", "\"+y")
keymap.set("n", "<leader>Y", "\"+Y")

-- Delete and send deletion to void register
keymap.set("n", "<leader>d", "\"_d")
keymap.set("v", "<leader>d", "\"_d")
keymap.set("n", "x", "\"_x")
keymap.set("v", "x", "\"_x")

-- Split windows
keymap.set("n", "<leader>sv", "<C-w>v") -- split vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split
keymap.set("n", "<C-h>", "<C-w>h") -- go to split on the left
keymap.set("n", "<C-l>", "<C-w>l") -- go to split on the right
keymap.set("n", "<C-j>", "<C-w>j") -- go to split down
keymap.set("n", "<C-k>", "<C-w>k") -- go to split up

keymap.set("n", "<leader>w", ":w<CR>")
-- nvim-tree
keymap.set("n", "<leader>fi", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>G", ":Git<CR>")

keymap.set("n", "<leader>rn", ":set rnu<CR>") -- set relative numbers
keymap.set("n", "<leader>nrn", ":set nornu<CR>") -- unset relative numbers

keymap.set("n", "<leader>pw", ":echo expand('%:p')<CR>") -- print current file location

-- Indent remaps. In LA input source in MAC, < & > don't exist
-- keymap.set("n", "<minus>", "<")
-- keymap.set("n", "<underscore>", ">")
