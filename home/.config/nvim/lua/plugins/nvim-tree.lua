return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
	keys = {
		{ "<leader>e", "<Esc>:NvimTreeFindFileToggle<CR>", desc = "nvim-tree" },
	},
	opts = function()
		local options = {
			disable_netrw = true,
			hijack_cursor = true,
			hijack_netrw = false,
			update_cwd = true,
			renderer = {
				group_empty = true,
				add_trailing = true,
				highlight_git = true,
				icons = {
					show = {
						git = false,
					},
				},
			},
			view = {
				number = true,
				relativenumber = true,
				width = 20,
				float = {
					enable = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 40,
						height = 40,
						row = 1,
						col = 1,
					},
				},
			},
			filters = {
				enable = true,
				dotfiles = false,
				custom = {
					"^\\.git$",
					".cache",
					"node_modules",
					"__pycache__",
				},
			},
			git = {
				enable = true,
				ignore = false,
				timeout = 400,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end
				-- api.config.mappings.default_on_attach(bufnr)
				vim.keymap.set("n", "<esc>", api.tree.close, opts("Close"))
				vim.keymap.set("n", "<leader>n", api.tree.close, opts("Close"))
				vim.keymap.set("n", "<leader>e", api.tree.close, opts("Close"))
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
				vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
				vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			end,
		}
		return options
	end,
}
