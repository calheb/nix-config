-- lua/plugins/lsp.lua

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup() -- no ensure_installed, Nix handles it

			vim.lsp.config("*", {
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.enable({
				"lua_ls",
				"clangd",
				"ts_ls",
				"cssls",
				"html",
				"bashls",
				"hls",
				"pyright",
				"jsonls",
				"nixd",
				"omnisharp",
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				sh = { "shfmt" },
				haskell = { "fourmolu" },
				python = { "black" },
				nix = { "nixpkgs_fmt" },
				cs = { "csharpier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
