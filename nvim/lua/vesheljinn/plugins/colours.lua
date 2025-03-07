function Bg(col)
	col = col or "rose-pine"
	vim.cmd.colorscheme(col)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- return {
-- 	{
-- 	"oxfist/night-owl.nvim",
-- 	config = function()
--         require("night-owl").setup({
--             bold = true,
--             italic = true,
--             underline = true,
--             undercurl = true,
--             transparent_background = false,
--         })
--         vim.cmd.colorscheme("night-owl")
--         -- Bg("night-owl")
-- 	end,
-- 	},
-- }
return {
	{
	"fynnfluegge/monet.nvim",
	config = function()
        require("monet").setup({
            transparent_background = false,
            semantic_tokens = true,
        })
        -- vim.cmd.colorscheme("monet")
        Bg("monet")
	end,
	},
}
