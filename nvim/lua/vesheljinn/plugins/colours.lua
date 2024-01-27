function Bg(col)
	col = col or "tokyonight"
	vim.cmd.colorscheme(col)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
return {
	{
	"folke/tokyonight.nvim",
	config = function()
		require("tokyonight").setup({
			style = "storm",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				sidebars = "dark",
				floats = "dark",
			},
            Bg()
		})
	end,
	},
}
