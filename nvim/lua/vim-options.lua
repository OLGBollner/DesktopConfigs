
vim.g.maplocalleader = ","
vim.g.mapleader = " "

--Add Row numbers
vim.cmd("set number")

--Highlight cursor line underneath the cursor horizontally.
vim.cmd("set cursorline")

--Highlight cursor line underneath the cursor vertically.
vim.cmd("set cursorcolumn")

--Set shift width to 4 spaces.
vim.cmd("set shiftwidth=4")

--Set tab width to 4 columns.
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")

--Use space characters instead of tabs.
vim.cmd("set expandtab")

--Do not save backup files.
vim.cmd("set nobackup")

--Do not let cursor scroll below or above N number of lines when scrolling.
vim.cmd("set scrolloff=10")

--Do not wrap lines. Allow long lines to extend as far as the line goes.
vim.cmd("set nowrap")

--While searching though a file incrementally highlight matching characters as you type.
vim.cmd("set incsearch")

--Ignore capital letters during search.
vim.cmd("set ignorecase")

--Override the ignorecase option if searching for capital letters.
--This will allow you to search specifically for capital letters.
vim.cmd("set smartcase")

--Show partial command you type in the last line of the screen.
vim.cmd("set showcmd")

--Show the mode you are on the last line.
--vim.cmd("set showmode")

--Show matching words during a search.
vim.cmd("set showmatch")

--Use highlighting when doing a search.
vim.cmd("set hlsearch")

--Set the commands to save in history default number is 20.
vim.cmd("set history=1000")

--Navigation short commands.
vim.keymap.set('n', '<leader>vv', ':vertical split<CR>')

vim.keymap.set('n', '<leader>ff', ':%s/')

vim.keymap.set('n', '<leader>df', ':vert diffs ')
