return {
    {
        "jpalardy/vim-slime",
        keys = {
            { "<leader>sc", "<cmd>SlimeConfig<cr>", desc = "Slime config" },
            { "<leader>ss", "<Plug>SlimeSendCell<BAR>/^# %%<CR>", desc = "Slime send cell" },
        },
        config = function()
            vim.g.slime_target = "tmux"
            vim.g.slime_cell_delimiter = "# %%"
            vim.g.slime_bracketed_paste = 1
        end,
    },
}
