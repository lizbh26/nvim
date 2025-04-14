return {
	"nvim-neotest/neotest",
	lazy = false,
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- Test adapters
		{ "fredrikaverpil/neotest-golang", version = "*" },
		"nvim-neotest/neotest-python",
		"sidlatau/neotest-dart",
		"rouge8/neotest-rust",
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-jest",
		"alfaix/neotest-gtest",
	},
	config = function()
		local mapfnkey = require("util.keymapper").mapfunctionkey
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-golang")({}),
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-dart")({
					command = "flutter",
					use_lsp = true,
				}),
				require("neotest-rust")({
					args = { "--no-capture" },
					dap_adapter = "lldb",
				}),
				require("neotest-vitest"),
				require("neotest-jest")({
					jestCommand = "npm test --",
				}),
				require("neotest-gtest").setup({}),
			},
		})

		mapfnkey("<leader>tr", function()
			neotest.run().run()
		end, "n", { desc = "Run the nearest test" })

		mapfnkey("<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, "n", { desc = "Run the current file" })

		mapfnkey("<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, "n", { desc = "Debug the nearest test" })

		mapfnkey("<leader>ts", function()
			neotest.run().stop()
		end, "n", { desc = "Stop the nearest test" })

		mapfnkey("<leader>to", function()
			neotest.summary().open()
		end, "n", { desc = "Open the test summary" })
	end,
}
