return {
	"NeogitOrg/neogit",
    lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		"nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
		local neogit = require("neogit")
		local mapfnkey = require("util.keymapper").mapfunctionkey

		mapfnkey("<leader>@n", function()
			neogit.open()
		end, "n", { desc = "Open Neogit" })

		mapfnkey("<leader>@c", function()
			neogit.open({ "commit" })
		end, "n", { desc = "Commit" })

		mapfnkey("<leader>@b", function()
			neogit.open({ "branch" })
		end, "n", { desc = "Open on branches" })

		mapfnkey("<leader>@d", function()
			neogit.open({ "diff" })
		end, "n", { desc = "Open diff" })

		mapfnkey("<leader>@s", function()
			neogit.open({ kind = "auto" })
		end, "n", { desc = "Split and Open Neogit" })
	end,
}
