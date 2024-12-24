return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{
			"<leader>n",
			":Oil<cr>",
			desc = "Oil",
		},
	},
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		columns = {
			"icon",
			"size",
		},
		view_options = {
			show_hidden = true,
		},
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
	},
}
