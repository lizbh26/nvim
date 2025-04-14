local mapvimkey = require("util.keymapper").mapvimkey
local mapfnkey = require("util.keymapper").mapfunctionkey

-- Replicate Alt-UpArrow and Alt-DownArrow from VSCode
mapfnkey("J", ":m '>+1<CR>gv=gv", "v")
mapfnkey("K", ":m '<-2<CR>gv=gv", "v")

-- Paste and delete without overriding register
mapfnkey("p", '"_dP', "x")
mapfnkey("x", '"_x', { "n", "v" })

-- Escape more easily from insert mode
mapfnkey("<C-c>", "<Esc>", "i")

local function formatAndSave()
	local efm = vim.lsp.get_clients({ name = "efm" })

	if not vim.tbl_isempty(efm) then
		vim.lsp.buf.format({ name = "efm", async = false })
	else
		vim.notify("Error: efm not found in LSP clients", 1)
	end

	vim.cmd("w")
end

mapfnkey("<leader>w", function()
	formatAndSave()
end, "n", { desc = "Format and save" })

mapfnkey("<leader>q", function()
	formatAndSave()
	vim.cmd("q")
end, "n", { desc = "Save and Quit" })

-- Move next line to the end of current line without moving cursor
mapfnkey("J", "mzJ`z", "n")

-- Center screen when moving
mapfnkey("<C-d>", "<C-d>zz", "n")
mapfnkey("<C-u>", "<C-u>zz", "n")

-- Search navigation
mapfnkey("n", "nzzzv", "n") -- Center screen when moving to next word
mapfnkey("N", "Nzzzv", "n")
mapvimkey("<leader>c", "nohlsearc", "n") -- Remove search highligh

-- Directory navigation
mapvimkey("<leader>ef", "NvimTreeFocus", "n")
mapvimkey("<leader>et", "NvimTreeToggle", "n")

-- Buffer Navigation
mapvimkey("<leader>bn", "bnext", "n", { desc = "Switch to next buffer" })
mapvimkey("<leader>bp", "bprevious", "n", { desc = "Switch to previous buffer" })
mapvimkey("<leader>bb", "e #", "n", { desc = "Switch to last buffer used" })
mapvimkey("<leader>`", "e #", "n", { desc = "Switch to last buffer used" })

-- Pane and Window Navigation
mapfnkey("<C-h>", "<C-w>h", "n") -- Navigate Left
mapfnkey("<C-j>", "<C-w>j", "n") -- Navigate Down
mapfnkey("<C-k>", "<C-w>k", "n") -- Navigate Up
mapfnkey("<C-l>", "<C-w>l", "n") -- Navigate Right
mapvimkey("<C-h>", "wincmd h", "t") -- Navigate Left
mapvimkey("<C-j>", "wincmd j", "t") -- Navigate Down
mapvimkey("<C-k>", "wincmd k", "t") -- Navigate Up
mapvimkey("<C-l>", "wincmd l", "t") -- Navigate Right
mapvimkey("<C-h>", "TmuxNavigateLeft", "n") -- Navigate Left
mapvimkey("<C-j>", "TmuxNavigateDown", "n") -- Navigate Down
mapvimkey("<C-k>", "TmuxNavigateUp", "n") -- Navigate Up
mapvimkey("<C-l>", "TmuxNavigateRight", "n") -- Navigate Right

-- Window management
mapvimkey("<leader>sv", "vsplit", "n", { desc = "Split vertically" })
mapvimkey("<leader>sh", "split", "n", { desc = "Split horizontally" })
mapfnkey("<leader>sq", "<C-w>q", "n", { desc = "Close window" })

-- Indenting
mapfnkey("<", "<gv", "v") -- Shift Indentation to Left
mapfnkey(">", ">gv", "v") -- Shift Indentation to Right

local api = vim.api
-- Comments
if vim.env.TMUX ~= nil then
	api.nvim_set_keymap("n", "<C-_>", "gtc", { noremap = false })
	api.nvim_set_keymap("i", "<C-_>", "<Esc>gtcA", { noremap = false })
	api.nvim_set_keymap("v", "<C-_>", "goc", { noremap = false })
else
	api.nvim_set_keymap("n", "<C-/>", "gtc", { noremap = false })
	api.nvim_set_keymap("i", "<C-/>", "<Esc>gtcA", { noremap = false })
	api.nvim_set_keymap("v", "<C-/>", "goc", { noremap = false })
end
