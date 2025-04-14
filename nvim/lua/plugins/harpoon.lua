return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local mapfnkey = require("util.keymapper").mapfunctionkey

		local harpoon = require("harpoon")
		harpoon:setup({})

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local make_file_finder = function()
				local paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(paths, item.value)
				end

				return require("telescope.finders").new_table({
					results = paths,
				})
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = make_file_finder(),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_buffer_number, map)
						map("i", "<C-d>", function()
							local state = require("telescope.actions.state")
							local selected_entry = state.get_selected_entry()
							local current_picker = state.get_current_picker(prompt_buffer_number)

							table.remove(harpoon_files.items, selected_entry.index)
							current_picker:refresh(make_file_finder())
						end)
						return true
					end,
				})
				:find()
		end

		mapfnkey("<C-e>", function()
			toggle_telescope(harpoon:list())
		end, "n", { desc = "Open harpoon window" })

		mapfnkey("<leader>a", function()
			harpoon:list():add()
			vim.notify("file added to harpoon", 2)
		end, "n", { desc = "Add window to harpoon list" })

		mapfnkey("<leader>nh", function()
			harpoon:list():next()
		end, "n", { desc = "Next harpoon" })

		mapfnkey("<leader>ph", function()
			harpoon:list():prev()
		end, "n", { desc = "Previous harpoon" })

		mapfnkey("<A-1>", function()
			harpoon:list():select(1)
		end, "n")
		mapfnkey("<A-2>", function()
			harpoon:list():select(2)
		end, "n")
		mapfnkey("<A-3>", function()
			harpoon:list():select(3)
		end, "n")
		mapfnkey("<A-4>", function()
			harpoon:list():select(4)
		end, "n")
		mapfnkey("<A-5>", function()
			harpoon:list():select(5)
		end, "n")
		mapfnkey("<A-6>", function()
			harpoon:list():select(6)
		end, "n")
		mapfnkey("<A-7>", function()
			harpoon:list():select(7)
		end, "n")
		mapfnkey("<A-8>", function()
			harpoon:list():select(8)
		end, "n")
		mapfnkey("<A-9>", function()
			harpoon:list():select(9)
		end, "n")
	end,
}
