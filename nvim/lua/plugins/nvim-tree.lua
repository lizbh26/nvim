local mapvimkey = require("util.keymapper").mapvimkey

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
		require("nvim-tree").setup({
			filters = {
				dotfiles = false,
			},
			view = {
				adaptive_size = true,
			},
		})

		mapvimkey("<leader>ef", "NvimTreeFocus", "n")
		mapvimkey("<leader>et", "NvimTreeToggle", "n")
	end,
}
