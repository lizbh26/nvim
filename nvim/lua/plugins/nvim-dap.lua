local debugging_signs = require("util.icons").debugging_signs
local mapfnkey = require("util.keymapper").mapfunctionkey

return {
	{
		"rcarriga/nvim-dap-ui",
		lazy = false,
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- set custom icons
			for name, sign in pairs(debugging_signs) do
				sign = type(sign) == "table" and sign or { sign }
				vim.fn.sign_define(
					"Dap" .. name,
					{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
				)
			end

			-- setup dapui
			dapui.setup()

			-- add event listeners
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			mapfnkey("<leader>yu", function()
				dapui.toggle()
			end, "n", { desc = "Toggle UI" })
		end,
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{
		"mfussenegger/nvim-dap",
		lazy = false,
		config = function()
			local dap = require("dap")

			-- configure adapters
			dap.adapters.gdb = { -- C/C++/Rust (via gdb)
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}

			-- Uses debugpy installed in a venv to debug python
			require("dap-python").setup(os.getenv("HOME") .. "/.virtualenvs/debugpy-venv/bin/python")

			-- Uses delve installed globaly to debug Go
			require("dap-go").setup()

			-- Uses firefox to debug JS and TS
			dap.adapters.firefox = {
				type = "executable",
				command = "node",
				args = { os.getenv("HOME") .. "/.virtualenvs/vscode-firefox-debug/dist/adapter.bundle.js" },
			}

			dap.configurations.typescript = {
				{
					name = "Debug with Firefox",
					type = "firefox",
					request = "launch",
					reAttach = true,
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "/usr/bin/firefox",
				},
			}

			-- Flutter and Dart through SDK
			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch dart",
					dartSdkPath = os.getenv("HOME") .. "/.flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
					flutterSdkPath = os.getenv("HOME") .. "/.flutter/bin/flutter", -- ensure this is correct
					program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
					cwd = "${workspaceFolder}",
				},
				{
					type = "flutter",
					request = "launch",
					name = "Launch flutter",
					dartSdkPath = os.getenv("HOME") .. "/.flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
					flutterSdkPath = os.getenv("HOME") .. "/.flutter/bin/flutter", -- ensure this is correct
					program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
					cwd = "${workspaceFolder}",
				},
			}

			-- Key bindings
			mapfnkey("<leader>yb", function()
				dap.toggle_breakpoint()
			end, "n", { desc = "Toggle breakpoint" })
			mapfnkey("<leader>yB", function()
				dap.clear_breakpoints()
			end, "n", { desc = "Clear all breakpoints" })
			mapfnkey("<leader>yl", function()
				dap.continue()
			end, "n", { desc = "Start or continue" })
			mapfnkey("<leader>ysi", function()
				dap.step_into()
			end, "n", { desc = "Step into" })
			mapfnkey("<leader>yso", function()
				dap.step_over()
			end, "n", { desc = "Step over" })
			mapfnkey("<leader>yi", function()
				dap.repl.open()
			end, "n", { desc = "Inspect" })
		end,
		dependencies = { "mfussenegger/nvim-dap-python", "leoluz/nvim-dap-go" },
	},
}
