-- lua/plugins/theme.lua

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}

--return {
--	{ "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
-- { "ellisonleao/gruvbox.nvim", name = "gruvbox", priority = 1000 },
--}

--return {
--	{
--		"blazkowolf/gruber-darker.nvim",
--		priority = 1000,
--		config = function()
--			vim.cmd.colorscheme("gruber-darker")
--		end,
--	},
--}
