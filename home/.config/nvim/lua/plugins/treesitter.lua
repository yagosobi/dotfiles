return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		ensure_installed = {
			"bash",
			"css",
			"dockerfile",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"rust",
			"scss",
			"sql",
			"terraform",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
			"prisma",
		},
		highlight = { enable = true },
		match = { enable = true },
		indent = { enable = true },
		textobjects = {
			select = {
				enable = true,
				lookahead = true,

				keymaps = {
					["af"] = { query = "@function.outer", desc = "around a function" },
					["if"] = { query = "@function.inner", desc = "inner part of a function" },
					["ac"] = { query = "@class.outer", desc = "around a class" },
					["ic"] = { query = "@class.inner", desc = "inner part of a class" },
					["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
					["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
					["al"] = { query = "@loop.outer", desc = "around a loop" },
					["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
					["ap"] = { query = "@parameter.outer", desc = "around parameter" },
					["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
				},
				selection_modes = {
					["@parameter.outer"] = "v",
					["@parameter.inner"] = "v",
					["@function.outer"] = "v",
					["@conditional.outer"] = "V",
					["@loop.outer"] = "V",
					["@class.outer"] = "<c-v>",
				},
				include_surrounding_whitespace = false,
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_previous_start = {
					["[f"] = { query = "@function.outer", desc = "previous function" },
					["[c"] = { query = "@class.outer", desc = "previous class" },
					["[p"] = { query = "@parameter.inner", desc = "previous parameter" },
				},
				goto_next_start = {
					["]f"] = { query = "@function.outer", desc = "next function" },
					["]c"] = { query = "@class.outer", desc = "next class" },
					["]p"] = { query = "@parameter.inner", desc = "next parameter" },
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>s"] = { query = "@parameter.inner", desc = "swap next parameter" },
				},
				swap_previous = {
					["<leader>S"] = { query = "@parameter.inner", desc = "swap previous parameter" },
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
