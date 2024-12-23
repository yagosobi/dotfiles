return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = { "lua_ls" },
		},
		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim", ft = "lua", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "rename symbol" })
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "code action" })
			vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format document" })
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "go to definition" })
			vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "go to implementation" })
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "to to references" })
			vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "signature help" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover document" })
			vim.keymap.set("n", "J", vim.diagnostic.open_float, { desc = "show line diagnostics" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next diagnostic" })

			-- diagnostic ui
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = false,
				signs = true,
				flags = {
					debounce_text_changes = 200,
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					source = "if_many",
					style = "minimal",
					border = "rounded",
					header = "",
					prefix = "",
				},
			})

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		end,
	},
}
