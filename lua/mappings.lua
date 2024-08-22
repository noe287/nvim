require "nvchad.mappings"


-----------------------------------------------------------------------------------------
---Modes:
--- normal_mode:"n",
--- insert_mode:"i",
--- visual_mode:"v",
--- visual_block_mode:"x",
--- term_mode:"t",
--- command_mode:"c",
-----------------------------------------------------------------------------------------

local opts = { noremap = true, silent = true }
-- Shorten function name
local map = vim.keymap.set
-- local setopt = vim.opt
local nmap = vim.api.nvim_set_keymap

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-----------------------------------------------------------------------------------------
-- Folding Keybindings
-----------------------------------------------------------------------------------------

-- zf#j creates a fold from the cursor down # lines
-- zf/ string creates a fold from the cursor to string.
-- zj moves the cursor to the next fold.
-- zk moves the cursor to the prevevious fold.
-- za toggle a fold at the cursor.
-- zo opens a fold at the cursor
-- zO opens all folds at the cursor
-- zc closes a fold under cursor.
-- zm increases the foldlevel by one.
-- zM closes all open folds.
-- zr decreases the foldlevel by one.
-- zR decreases the foldlevel to zero -- all folds will be open.
-- zd deletes the fold at the cursor.
-- zE deletes all folds.
-- [z move to start of open fold.
-- z move to end of open fold.
-----------------------------------------------------------------------------------------
-- NORMAL MODE
-----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--- Save and Close all the windows
map("n", "<C-d>", ":qa! <CR>", {desc = "Close NVIM without saving"})
--- Close all the windows without saving
map("n", "<C-a>", ":wqa! <CR>", {desc = "Save and Close NVIM"})
-- Switch to normal mode and then save the file, in all modes.
map("i", "<C-s>", "<ESC>+:w! <CR>", {desc = "Save File"})
map("v", "<C-s>", "<ESC>+:w! <CR>", {desc = "Save File"})
map("x", "<C-s>", "<ESC>+:w! <CR>", {desc = "Save File"})
--- Modify default setting to switch between split windows as below
nmap("n", "<C-h>", "<C-w>h", {desc = "Switch to Left pane"})
nmap("n", "<C-j>", "<C-w>j", {desc = "Switch to up pane"})
nmap("n", "<C-k>", "<C-w>k", {desc = "Switch to down pane"})
nmap("n", "<C-l>", "<C-w>l", {desc = "Switch to right pane"})
-- Resize split windows:
map("n", "<C-w><F10>", ":resize -10<CR>", {desc = "Resize Horizontal pane -10"})
map("n", "<C-w><F11>", ":resize +10<CR>", {desc = "Resize Horizontal pane +10"})
map("n", "<C-w><F9>", ":vertical resize -10<CR>", {desc = "Resize Vertical pane -10"})
map("n", "<C-w><F12>", ":vertical resize +10<CR>", {desc = "Resize Vertical pane +10"})
-- Close the current window
nmap("n", "<C-x>", "<C-w>q", {desc = "Close the current window"})
-- map("n", "gd", ":Telescope lsp_definition<CR>")
-- Insert empty line without entering insert mode
map('n', '<leader>o', ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', {desc = "Insert empty line below: Normal Mode"})
map('n', '<leader>O', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', {desc = "Insert empty line in above: Normal Mode"})
-- Needed to remap these as c-i did not work for some reason.
map('n', '<C-o>', '<C-o>', {desc = "Jump forward"})
map('n', '<C-i>', '<C-i>', {desc = "Jump backward"})
-- Remap sroll down and scroll up and center the result
map('n', ',', '<C-u>zz', {desc = "Scroll Up"})
map('n', 'm', '<C-d>zz', {desc = "Scroll Down"})
map('n', 'M', 'mzz', {desc = "Go to Midline"})
-- Select all
map("n", "==", "gg<S-v>G", {desc = "Select All"})
-- Paste without overwriting register
map("v", "p", '"_dP', {desc = "Paste without overwriting register"})
-- Replace word under cursor across entire buffer
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor in the whole file" })
-- Use U for redo :))
map('n', 'U', '<C-r>', {desc = "Redo last change"})
-- Tooggle QFIX window
-- use <C-N> and <C-P> for next/prev.
-- map("n", "<C-N>", "<CMD>QNext<CR>", opts)
-- map("n", "<C-P>", "<CMD>QPrev<CR>", opts)
-- toggle the quickfix open/closed without jumping to it
map("n", "<leader>q", "<CMD>QFToggle!<CR>", {desc = "Toggle Quickfix"})
map("n", "<leader>l", "<CMD>LLToggle!<CR>", {desc = "Toggle DiagnosticQickfix"})
-- Toggle see whitespace characters like: eol, space, ...
map('n', '<F6>', ':set list!<cr>', {desc = "Toogle invible characters in the file"})
-- Toggle SymbolList
map('n', '\\', ':SymbolsOutline<CR>', {desc = "SymbolistToggle"})
-- Toggle Paste
-- map('n', '<F5>', ':set paste!<cr>', opts)
-- map('i', '<F5>', '<ESC>:set paste!<cr>', opts)
-- Alt/Meta + c to capitalize the first character of an inner word
map('n', '<M-c>', 'guiw~w', {desc = "Capitalize the first C of a word"})
-- Alt/Meta + u to uppercase the inner word
map('n', '<M-u>', 'gUiww', {desc = "Capitalize the word"})
-- Alt/Meta + l to lowercase the inner word
map('n', '<M-l>', 'guiww',{desc = "Lowercase the word"})


-- Fast searching text under cursor with Goole with Ctrl+q Ctrl+g
-- I am using ArchLinux so I use the xdg-open command
-- For other file system it can be opEn
local searching_google_in_normal =
[[:lua vim.fn.system({'xdg-open',
'https://google.com/search?q=' .. vim.fn.expand("<cword>")})<CR>]]
map("n", "<C-q><C-g>", searching_google_in_normal, {desc = "Search the word on Google"})

-----------------------------------------------------------------------------------------
-- VISUAL MODE
-----------------------------------------------------------------------------------------
-- Move block of lines
-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", {desc = "Move the selected block up 1 line"})
map("v", "<A-k>", ":m .-2<CR>==", {desc = "Move the selected block down 2 lines"})

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", {desc = "Move the selected block up 1 line"})
map("x", "K", ":move '<-2<CR>gv-gv", {desc = "Move the selected block down 2 lines"})
-- map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-----------------------------------------------------------------------------------------
-- Toggle linter to remove cluttering the screen
vim.g["diagnostics_active"] = true
function Toggle_diagnostics()
    if vim.g.diagnostics_active then
        vim.g.diagnostics_active = false
        vim.diagnostic.disable()
    else
        vim.g.diagnostics_active = true
        vim.diagnostic.enable()
    end
end

map('n', '<leader>xd', Toggle_diagnostics, { noremap = true, silent = true, desc = "Toggle Vim diagnostics" })

-----------------------------------------------------------------------------------------
-- END Keymaps
-----------------------------------------------------------------------------------------
