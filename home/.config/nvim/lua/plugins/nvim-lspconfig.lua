local M = {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "saghen/blink.cmp" },
	},
}

function M.on_attach(_, bufnr)
	local map = function(key, func, desc)
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		bufopts.desc = "LSP: " .. desc
		return vim.keymap.set("n", key, func, bufopts)
	end

	map("M", vim.diagnostic.open_float, "show line diagnostics")
	map("ga", vim.lsp.buf.code_action, "code action")
	map("gd", vim.lsp.buf.definition, "go to definition")
	map("<leader>fd", "<cmd>FzfLua lsp_definitions<cr>", "go to definition")
	map("gi", vim.lsp.buf.implementation, "go to implementation")
	map("<leader>fi", "<cmd>FzfLua lsp_implementations<cr>", "go to implementation")
	map("gr", vim.lsp.buf.references, "go to references")
	map("<leader>fr", "<cmd>FzfLua lsp_references<cr>", "go to references")
	map("gs", vim.lsp.buf.signature_help, "signature help")
	map("[d", vim.diagnostic.goto_prev, "previous diagnostic")
	map("]d", vim.diagnostic.goto_next, "next diagnostic")
	map("<leader>rn", vim.lsp.buf.rename, "rename symbol")
	map("\\f", function()
		vim.lsp.buf.format({ async = true })
	end, "format document")
end

function M.config()
	local lspconfig = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	vim.diagnostic.config({
		virtual_text = false,
	})

	-- Diagnostics symbols for display in the sign column.
	local signs = { Error = "", Warn = "", Hint = "", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}
	vim.diagnostic.config(config)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	require("mason").setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
	mason_lspconfig.setup({
		ensure_installed = {
			"bashls",
			"lua_ls",
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"jsonls",
		},
	})
	mason_lspconfig.setup_handlers({
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function(server_name) -- default handler (optional)
			lspconfig[server_name].setup({
				on_attach = M.on_attach,
				capabilities,
			})
		end,
		["html"] = function()
			lspconfig.html.setup({
				on_attach = M.on_attach,
				capabilities,
				filetypes = { "html" },
			})
		end,
		["jsonls"] = function()
			lspconfig.jsonls.setup({
				on_attach = M.on_attach,
				capabilities,
				commands = {
					Format = {
						function()
							vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
						end,
					},
				},
			})
		end,
		["tailwindcss"] = function()
			lspconfig.tailwindcss.setup({
				on_attach = M.on_attach,
				capabilities,
				settings = {
					tailwindCSS = {
						classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidConfigPath = "error",
							invalidScreen = "error",
							invalidTailwindDirective = "error",
							invalidVariant = "error",
							recommendedVariantOrder = "warning",
						},
						validate = true,
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			})
		end,
	})
end

return M