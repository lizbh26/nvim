return {
	"RRethy/vim-illuminate",
	lazy = false,
	config = function()
		require("illuminate").configure({
			filetypes_denylist = {
				"dirbuf",
				"dirvish",
				"fugitive",
				"html",
                "json",
                "jsonc",
                "markdown",
			},
		})
	end,
}
