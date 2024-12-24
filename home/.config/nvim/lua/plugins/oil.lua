return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{
			"<leader>n",
			"<cmd>Oil<cr>",
			desc = "oil",
		},
	},
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		columns = {
			"icon",
		},
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["<C-b>"] = { "actions.parent", mode = "n" },
			["~"] = { "actions.open_cwd", mode = "n" },
			["<leader>n"] = { "actions.close", mode = "n" },
			["<leader>e"] = { "actions.close", mode = "n" },
			["<C-r>"] = "actions.refresh",
			["-"] = false,
			["_"] = false,
			["`"] = false,
			["<C-h>"] = false,
			["<C-l>"] = false,
			["<C-t>"] = false,
			["<C-s>"] = false,
		},
	},
}
