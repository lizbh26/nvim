return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	config = function()
		local mapvimkey = require("util.keymapper").mapvimkey

		mapvimkey("<C-h>", "TmuxNavigateLeft", "n") -- Navigate Left
		mapvimkey("<C-j>", "TmuxNavigateDown", "n") -- Navigate Down
		mapvimkey("<C-k>", "TmuxNavigateUp", "n") -- Navigate Up
		mapvimkey("<C-l>", "TmuxNavigateRight", "n") -- Navigate Right
	end,
}
