return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {
				tab_char = "│",
			},
		})
	end,
}
