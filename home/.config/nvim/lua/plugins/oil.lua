return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{
			"<leader>n",
			":Oil<cr>",
			desc = "oil",
		},
	},
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
			"size",
		},
		delete_to_trash = true,
		keymaps = {
			["<C-b>"] = { "actions.parent", mode = "n" },
			["~"] = { "actions.open_cwd", mode = "n" },
			["<leader>n"] = { "actions.close", mode = "n" },
			["<leader>e"] = { "actions.close", mode = "n" },
			["-"] = false,
			["_"] = false,
			["`"] = false,
			["<C-h>"] = false,
			["<C-t>"] = false,
			["<C-s>"] = false,
		},
		view_options = {
			show_hidden = true,
		},
	},
}
