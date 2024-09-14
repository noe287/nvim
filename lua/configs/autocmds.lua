-- The whole file is Noe's creation.
-----------------------------------------------------------------------------------------
--START Autocommands:
-----------------------------------------------------------------------------------------
-- Highlight the yanked lines
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

augroup("NoeGroup", {clear = true})
-- Highlight on yank
autocmd("TextYankPost", {
    group = "NoeGroup",
    pattern = "*",
    callback = function() vim.highlight.on_yank {timeout = 100} end
})
-- Remove whitespace on save
autocmd('BufWritePre', {
    group = "NoeGroup",
    pattern = '',
    command = ":%s/\\s\\+$//e"
})
-- Don't auto comment new lines
autocmd('BufEnter', {
    group = "NoeGroup",
    pattern = '',
    command = 'set fo-=c fo-=r fo-=o'
})
-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
    group = "NoeGroup",
    command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

-- Start with a clean jump table that is populated with c-o/c-i
autocmd('VimEnter', {
    group = "NoeGroup",
    command = 'clearjumps',
})
--------------------------------------------------------------- --------------------------
-- Nvim-Tree START
--------------------------------------------------------------- --------------------------
-- disable netrw at the very start of your init.lua

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 0

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using opts
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        -- You can toggle hidden file view with H at the run time.
        dotfiles = true,
    },
})

local function open_nvim_tree()
    -- open the tree
    require("nvim-tree.api").tree.open()
end

autocmd({ "VimEnter" }, { callback = open_nvim_tree })


-----------------------------------------------------------------------------------------
-- Nvim-Tree END
-----------------------------------------------------------------------------------------



