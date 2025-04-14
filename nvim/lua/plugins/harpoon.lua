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
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		mapfnkey("<C-e>", function()
			toggle_telescope(harpoon:list())
		end, "n", { desc = "Open harpoon window" })

		mapfnkey("<leader>a", function()
			harpoon:list():add()
		end, "n", { desc = "Add window to harpoon list" })

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
